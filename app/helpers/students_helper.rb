module StudentsHelper
   def semester_options
       # 此處邏輯對應到 views/students/_form.html.erb
       Semester.all.order('id DESC').map{ |c| [c.name, c.id] }
   end
end
