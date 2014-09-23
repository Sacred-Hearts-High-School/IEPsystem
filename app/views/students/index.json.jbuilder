json.array!(@students) do |student|
  json.extract! student, :id, :name, :no, :pid, :email, :stu_type, :stu_class, :disable_desc, :father, :father_phone, :mother, :mother_phone, :phone
  json.url student_url(student, format: :json)
end
