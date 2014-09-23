json.array!(@semesters) do |semester|
  json.extract! semester, :id, :year, :semester, :name
  json.url semester_url(semester, format: :json)
end
