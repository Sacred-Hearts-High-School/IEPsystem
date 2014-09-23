class ClassroomsController < ApplicationController

  before_action :login_required, :admin_required
  before_action :set_classroom, only: [:show, :edit, :update, :destroy]

  def add_students
    @classroom = Classroom.find(params[:id])
    @stu = params[:students].split(' ')

    msg =""

    @stu.each do |s|
       @findstu = Student.find_by(name: s.to_s)
       if @findstu
          @sinc = SInC.create(classroom_id: @classroom.id, student_id: @findstu.id)
          msg += "\"" + s.to_s + " 新增成功\"、"
       else
          msg += "\"" + s.to_s + " 新增失敗\"、"
       end
    end

    respond_to do |format|
        format.html { redirect_to @classroom, notice: '新增學生結果：'+msg }
        format.json { head :no_content }
    end
  end

  def add_teachers
    @classroom = Classroom.find(params[:id])
    @tea = params[:teachers].split(' ')

    msg =""

    guru = 0

    @tea.each do |t|
       @findtea = Teacher.find_by(name: t.to_s)
       if @findtea
          @tinc = TInC.create(classroom_id: @classroom.id, teacher_id: @findtea.id, subject: @findtea.subject1, role: guru)
          guru=1 if guru=0
          msg += "\"" + t.to_s + " 新增成功\"、"
       else
          msg += "\"" + t.to_s + " 新增失敗\"、"
       end
    end

    respond_to do |format|
        format.html { redirect_to @classroom, notice: '新增教師結果：'+msg }
        format.json { head :no_content }
    end
  end

  def remove_a_student
     @classroom = Classroom.find(params[:cid])
     @sinc = SInC.find(params[:id])
     @sinc.destroy
     respond_to do |format|
        format.html { redirect_to @classroom, notice: '已經移除學生' }
        format.json { head :no_content }
     end
  end

  def remove_a_teacher
     @classroom = Classroom.find(params[:cid])
     @tinc = TInC.find(params[:id])
     @tinc.destroy
     respond_to do |format|
        format.html { redirect_to @classroom, notice: '已經移除教師' }
        format.json { head :no_content }
     end
  end

  # GET /classrooms
  # GET /classrooms.json
  def index
    @classrooms = Classroom.all
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
     @sinc = SInC.where("classroom_id=?",params[:id])
     @tinc = TInC.where("classroom_id=?",params[:id])
  end

  # GET /classrooms/new
  def new
    @classroom = Classroom.new
  end

  # GET /classrooms/1/edit
  def edit
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)

    respond_to do |format|
      if @classroom.save
        format.html { redirect_to @classroom, notice: '成功新增班級。' }
        format.json { render action: 'show', status: :created, location: @classroom }
      else
        format.html { render action: 'new' }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /classrooms/1
  # PATCH/PUT /classrooms/1.json
  def update
    respond_to do |format|
      if @classroom.update(classroom_params)
        format.html { redirect_to @classroom, notice: 'Classroom was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @classroom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    @classroom.destroy
    respond_to do |format|
      format.html { redirect_to classrooms_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.require(:classroom).permit(:semester_id, :num, :name)
    end
end
