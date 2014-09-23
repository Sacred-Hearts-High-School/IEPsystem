json.array!(@posts) do |post|
  json.extract! post, :id, :title, :content, :user_id, :teacher_id, :student_id, :classroom_id, :permission
  json.url post_url(post, format: :json)
end
