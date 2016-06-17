class AddPastCourseIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :past_course_id, :integer
  end
end
