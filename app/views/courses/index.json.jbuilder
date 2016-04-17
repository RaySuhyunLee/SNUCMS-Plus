json.array!(@courses) do |course|
  json.extract! course, :id, :university, :classification, :college, :department, :level, :grade, :course_num, :lecture_num, :title, :credit, :timetable, :location
  json.url course_url(course, format: :json)
end
