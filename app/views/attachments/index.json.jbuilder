json.array!(@attachments) do |attachment|
  json.extract! attachment, :id, :classroom_id, :student_id, :teacher_id, :post_id, :title, :content, :filename, :type, :status
  json.url attachment_url(attachment, format: :json)
end
