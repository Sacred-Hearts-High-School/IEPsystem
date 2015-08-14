class TasksController < ApplicationController

   before_action :set_task, only: [:show,:comment,:upload]

   def my
      @teacher = Teacher.find_by(email: current_user.email)
      @tasks = Task.where("teacher_id=?", @teacher.id)
   end

   def show

      # task 及 comment 一定要倚賴 post
      @comments = Comment.where("post_id=?",@task.post_id)

      case @task.genus
      when 1   
         # 期初 IEP
         if @task.status < 40    # 大於 40 表示不需處理
            render
         else
            render "dealt" and return
         end
      when 2
         # 期末 IEP
         if @task.status < 40
            render "iep2"
         else
            render "dealt" and return
         end
      when 4   
         # 期初導師會議紀錄
         if @task.status < 40    # 大於 40 表示不需處理
            render "iep4"
         else
            render "dealt" and return
         end
      when 8
         render "comment"
      end

   end

   def comment

      @task.update_attribute(:status,50)

      # 新增一則留言
      @comment = Comment.new
      @comment.teacher_id = @task.teacher_id
      @comment.post_id = @task.post_id
      @comment.content = params[:content]
      if @comment.save
         @task.update_attribute(:status,90)
         redirect_to "/tasks/"+params[:token], :flash=>{:success=>"您已經順利留言！"}
      else
         redirect_to "/tasks/"+params[:token], :flash=>{:error=>"留言失敗，因為字數不足！"}
      end

   end

   def upload

      if current_user.nil?   
         username = @task.teacher.name + "*"
      else
         username = current_user.name
      end

      if params[:commit]=="我的任課科目不須撰寫IEP"
         @task.update_attribute(:status,50)
         @task.post.update_attribute(:content, @task.post.content + 
                      "<br>" + username + "更新狀態：該科不須撰寫IEP。<br>")
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
         @task.post.update_attribute(:content, @task.post.content +
          "<br>" + username + "已上傳檔案："+@attachment.filename+"<br>")

         msg = "檔案已經上傳！ 檔名：" + @attachment.filename
      end

      redirect_to "/tasks/"+params[:token], notice: msg

   end

   private 

   def set_task
      @task = Task.find_by(token: params[:token])
   end

end
