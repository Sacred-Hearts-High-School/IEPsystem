json.array!(@teachers) do |teacher|
  json.extract! teacher, :id, :email, :subject1, :subject2
  json.url teacher_url(teacher, format: :json)
end
