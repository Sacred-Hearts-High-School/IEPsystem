class AdminController < ApplicationController

   before_action :login_required, :admin_required

   def mailer
      @tasks = Task.where("status<=40")
      @tasks.each do |t|
         UserMailer.iep1_email(t.id).deliver
      end
      redirect_to "/admin/list_tasks", notice: "任務通知寄信已經完成!"
   end

   def list_taskgroups
      @taskgroups = Taskgroup.all
   end

   def edit_task
   end

   def delete_task
      @task = Task.find(params[:id])
      @task.destroy
      redirect_to "/admin/list_tasks"
   end

   def create_tasks

      # 找出當前學期，這裡要修改！
      @seme = Semester.find(5)
      # 找出所有本學期的班級
      @classrooms = Classroom.where("semester_id=?",@seme.id)

      @classrooms.each do |c|
         # 找出所有班級內的學生跟老師
         @sinc = SInC.where("classroom_id=?",c.id)
         @tinc = TInC.where("classroom_id=?",c.id)


         @sinc.each do |s|
            @post = Post.new
            @post.title = @seme.name + c.name + s.student.name + "期初IEP計畫"
            @post.content = "期初IEP計畫"
            @post.user_id = current_user.id
            @post.permission = 30
            @post.taxonomies = "IEP"
            @post.save!

            @taskgroup = Taskgroup.new
            @taskgroup.title = @seme.name + c.name + s.student.name + "期初IEP計畫"
            @taskgroup.save!

            @tinc.each do |t|
               @task = Task.new
               @task.taskgroup_id = @taskgroup.id
               @task.classroom_id = c.id
               @task.student_id = s.student.id
               @task.teacher_id = t.teacher.id
               @task.post_id = @post.id
               @task.title = @seme.name + c.name + s.student.name + "期初IEP計畫-" + t.teacher.name
               @task.status = 0
               @task.save!
            end
         end
      end

      redirect_to "/admin/list_tasks"
   end

   def list_tasks
      @tasks = Task.all
   end

   def index
      redirect_to "/admin/menu"
   end

   def menu
   end

   def edit_tinc
      @tinc = TInC.find(params[:id])
   end

   def save_tinc
      @tinc = TInC.find(params[:id])
      @tinc.subject = params[:subject]
      @tinc.role = params[:role]
      @classroom = Classroom.find(@tinc.classroom_id)
      @tinc.save
      redirect_to @classroom
   end

   # 列印開會通知
   def print1
      year = (params[:seme].to_i / 10)
      seme = (params[:seme].to_i) % 10

      @msg = year.to_s + "學年 第" + seme.to_s + "學期"

      @semesters = Semester.where("year=? and semester=?",year,seme)
      @classrooms = Classroom.where("semester_id=?",@semesters[0].id)

      cq=""
      index=0
      @classrooms.each do |c|
         if index==0
            cq += " classroom_id=" + c.id.to_s + " " 
         else 
            cq += " or classroom_id=" + c.id.to_s + " "
         end
         index += 1
      end

      @tinc = TInC.where(cq).group("teacher_id")

      render :layout => "printer"

   end

   # 列印會議簽到表，下一版把內容放到 views，變數丟進去就好。
   def print2
      year = (params[:seme].to_i / 10)
      seme = (params[:seme].to_i) % 10

      @msg = ""

      @semesters = Semester.where("year=? and semester=?",year,seme)
      @classrooms = Classroom.where("semester_id=?",@semesters[0].id)

      @classrooms.each do |c|
         @sinc = SInC.where("classroom_id=?",c.id)
         @tinc = TInC.where("classroom_id=?",c.id)

         @sinc.each do |s|

             @msg += "<div class='kai'>"
             @msg += "<p><h1>雲林縣身心障礙學生個別化教育計畫擬定會議紀錄</h1></p><br />"
             @msg +="&nbsp;&nbsp;&nbsp;學校：正心中學   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;          日期：
                             103年08月19日<br />"
             @msg += "&nbsp;&nbsp;&nbsp;學生姓名："+s.student.try(:name)
             @msg += "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;      就讀班級："+c.name+"班 <br />"
                             
             index=0

             @guru = TInC.where("classroom_id=? and role=0",c.id)

             @msg += "&nbsp;&nbsp;&nbsp;主席："+@guru[0].teacher.try(:name)
             @msg += "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                       紀錄：<br />"
             @msg += "&nbsp;&nbsp;&nbsp;列席人員：校長：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                  教務主任：<br />"
             @msg += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;         學務主任：    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;                      總務主任：<br />"
             @msg += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;         輔導主任：<br />"
             @msg += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;         教育局代表：<br />"
             @msg += "&nbsp;&nbsp;&nbsp;出席人員："

             @msg += "<table width=99% align=center>\n"
             @msg += "<tr height>"
             @msg += "<th width=19%>職稱</th><th width=12%>姓名</th><th width=19%>簽名</th>"
             @msg += "<th width=19%>職稱</th><th width=12%>姓名</th><th width=19%>簽名</th>"
             @msg += "</tr>\n"
             @msg += "<tr><td>特教組長</td><td>詹嘉隆</td><td></td>"
                                                      
             index+=1

             @tinc.each do |t|
                 @msg += "<tr>" if (index % 2 == 0) 
                 @msg += "<td>"+t.subject+"教師</td><td> "+t.teacher.try(:name)+" </td><td></td>"
                 @msg += "</tr>\n" if(index % 2 == 1) 
                 index+=1
             end
             @msg += "<td></td><td></td><td></td></tr>\n" if index%2 == 1

             @msg += "<tr><td><font color=white>教師</font></td><td></td><td></td><td></td><td></td><td></td></tr>\n"
             @msg += "<tr><td colspan=2>家長簽名</td><td colspan=4></td></tr>"
             @msg += "</table><p />\n"

             @msg += "&nbsp;   建議配合相關服務：（請依序註明執行人員、執行方式、執行期限）<br />\n"
             @msg += "&nbsp;   □  交通服務項目：<br />\n"
             @msg += "&nbsp;   □  物理治療：<br />\n"
             @msg += "&nbsp;   □  職能治療：<br />\n"
             @msg += "&nbsp;   □  語言治療：<br />\n"
             @msg += "&nbsp;   □  聽力檢查：<br />\n"
             @msg += "&nbsp;   □  學生衛生保健：<br />\n"
             @msg += "&nbsp;   □  心理輔導：<br />\n"
             @msg += "&nbsp;   □  休閒娛樂：<br />\n"
             @msg += "&nbsp;   □  輔具：<br />\n"
             @msg += "&nbsp;   □  其他（請註明）：<br />\n"
             @msg += "</font>\n"
             @msg += "<P STYLE=\"page-break-before: always;\"></P></div>\n"

         end
      end

      render :layout=>"printer"

   end


   def print_students

      year = (params[:seme].to_i / 10)
      seme = (params[:seme].to_i) % 10

      @msg = "<h2>" + year.to_s + "學年 第" + seme.to_s + "學期特教生名單</h2>"
      @msg += "※機密文件，請妥善保管 ※<br><br>"

      @semesters = Semester.where("year=? and semester=?",year,seme)
      @classrooms = Classroom.where("semester_id=?",@semesters[0].id)

      @msg += "<table width=99% align=center>\n"

      @classrooms.each do |c|
         @sinc = SInC.where("classroom_id=?",c.id)
         @tinc = TInC.where("classroom_id=? and role=0",c.id)

         @sinc.each do |s|
            @msg += "<tr height>"
            @msg += "<td width=80>" + c.name + "</td>"
            @msg += "<td width=80>" + s.student.name + "</td>"
            @msg += "<td width=100>" + s.student.stu_class + "</td>"
            @msg += "<td>" + s.student.disable_desc + "</td></tr>\n"
         end

      end

      @msg += "</table>\n<br><br>"
      @msg += "※機密文件，請妥善保管 ※"
      @msg += " 列印日期：" + Time.now().to_s
      render :layout => "printer"
   end

end
