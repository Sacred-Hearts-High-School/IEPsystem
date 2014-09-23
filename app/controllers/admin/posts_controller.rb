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
