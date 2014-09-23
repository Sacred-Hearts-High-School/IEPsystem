class StudentsController < ApplicationController

  before_action :login_required, :admin_required
  before_action :set_student, only: [:show, :edit, :addc, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # add the student to classroom
  def addc
     @classroom = Classroom.all
  end

  def dealaddc
     @classrooms = Classroom.where("semester_id=? and num=?",params[:seme],params[:clas])
     if @classrooms
        @c = @classrooms[0]
        @sinc = SInC.create(classroom_id: @c.id, student_id: params[:id])
     end
     @sinc
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: '已經成功新增學生。' }
        format.json { render action: 'show', status: :created, location: @student }
      else
        format.html { render action: 'new' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: '成功更新學生的資料。' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :no, :pid, :email, :stu_type, :stu_class, :disable_desc, :father, :father_phone, :mother, :mother_phone, :phone)
    end
end
