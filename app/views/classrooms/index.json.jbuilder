json.array!(@classrooms) do |classroom|
  json.extract! classroom, :id, :semester_id, :num, :name
  json.url classroom_url(classroom, format: :json)
end
