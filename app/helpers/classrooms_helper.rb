module ClassroomsHelper
   def semester_options
       # 此處邏輯對應到 views/classrooms/_form.html.erb
       Semester.all.order('id DESC').map{ |c| [c.name, c.id] }
   end
end
