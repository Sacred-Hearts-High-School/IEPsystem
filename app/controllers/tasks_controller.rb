class TasksController < ApplicationController

   before_action :set_task, only: [:show,:upload]

   def my
      @teacher = Teacher.find_by(email: current_user.email)
      @tasks = Task.where("teacher_id=?", @teacher.id)
   end

   def show
      if @task.status >= 40  # 表示不須處理
         render "dealt" and return
      else
         render 
      end
   end

   def upload

      if params[:commit]=="我的任課科目不須撰寫IEP"
         @task.update_attribute(:status,50)
         @task.post.update_attribute(:content, @task.post.content + 
                                     "<br>" + current_user.name + "更新狀態：該科不須撰寫IEP。<br>")
         msg = '任務資料已經更新！'
      elsif params[:datafile] == nil
         msg = "您似乎沒有先選擇要上傳的檔案？"
      else

         file = params[:datafile]
         orig_name =  file.original_filename
         ext_name = File.extname(orig_name)
         name = File.basename(@task.title, ext_name)

         # 檔案放在 ~/IEPsystem/data
         directory = "data"
         # create the file path
         path = File.join(directory, name+ext_name)
         
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
         @attachment.classroom_id = @task.classroom_id
         @attachment.student_id = @task.student_id
         @attachment.teacher_id = @task.teacher_id
         @attachment.post_id = @task.post_id
         @attachment.title = @task.title
         @attachment.content = @task.content
         @attachment.filename = File.basename(path) 
         @attachment.genus = 1   # 尚未完全定案
         @attachment.save!

         # 已經處理尚未審核
         @task.update_attribute(:status,60)
         @task.post.content += current_user.name + "已上傳檔案："+@attachment.filename+"<br>"

         msg = "檔案已經上傳！ 檔名：" + @attachment.filename
      end

      redirect_to "/tasks/"+params[:token], notice: msg

   end

   private 

   def set_task
      @task = Task.find_by(token: params[:token])
   end

end
