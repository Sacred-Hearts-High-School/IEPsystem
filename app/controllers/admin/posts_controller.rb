class Admin::PostsController < ApplicationController
  before_action :login_required, :admin_required
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @attachments = Attachment.where("post_id=?", @post.id)
    @students = Student.all
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = session[:user_id]

    # 建立新標籤
    @tags = @post.taxonomies.split(' ')
    @tags.each do |t|
       @taxo = Taxonomy.new
       @taxo.name = t
       @taxo.post_id = @post.id
       @taxo.save
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to admin_post_path(@post.id), notice: '成功張貼新文章！' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def download
    @attachment = Attachment.find(params[:id])
    @file = 'data/' + @attachment.filename
    send_file @file, :x_sendfile=>true
  end

  def upload
    @post = Post.find(params[:id])
    file = params[:datafile]

    orig_name =  file.original_filename
    ext_name = File.extname(orig_name)
    name = File.basename(orig_name, ext_name)

    # 檔案放在 ~/IEPsystem/data
    directory = "data"
    # create the file path
    path = File.join(directory, orig_name)

    # 判斷是否有同名的檔案
    i=1
    while File.exist?(path)
       path = File.join(directory, name+"("+i.to_s+")"+ext_name)
       i+=1
    end

    # write the file
    File.open(path, "wb") { |f| f.write(file.read) }

    # 寫入資料庫
    @attachment = Attachment.new
    @attachment.post_id = @post.id
    if params[:title]
       @attachment.title = params[:title] 
    else
       @attachment.title = "無標題"
    end
    @attachment.filename = File.basename(path) 
    @attachment.save
    redirect_to admin_post_path(@post.id), notice: '成功上傳檔案！ 檔名：'+orig_name
  end


  def deletefile
    @attachment = Attachment.find(params[:id]) 
    post = @attachment.post_id
    filename = @attachment.filename
    File.delete("data/"+filename)
    @attachment.destroy
    redirect_to admin_post_path(post), notice: '成功刪除檔案！ 檔名：'+filename
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update

    # 更新張貼者資料
    @post.user_id=session[:user_id]

    # 先刪掉舊有的標籤 
    @taxo = Taxonomy.where("post_id=?", @post.id)
    @taxo.each do |t|
       t.destroy
    end

    # 再更新為新標籤
    @tags = @post.taxonomies.split(' ')
    @tags.each do |t|
       @taxo = Taxonomy.new
       @taxo.name = t
       @taxo.post_id = @post.id
       @taxo.save
    end

    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to admin_post_path(@post.id), notice: '文章已經成功更新！' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy

    # 先刪掉舊有的標籤 
    @taxo = Taxonomy.where("post_id=?", @post.id)
    @taxo.each do |t|
       t.destroy
    end

    @post.destroy
    respond_to do |format|
      format.html { redirect_to admin_posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :teacher_id, :student_id, :classroom_id, :permission, :taxonomies)
    end
end
