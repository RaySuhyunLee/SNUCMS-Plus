class RemoveUnusedColumnsFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :professor_id, :integer
    remove_column :courses, :school_id, :integer
    remove_column :courses, :past_course_id, :integer
  end
end
