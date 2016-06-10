class AmendCourseSchema < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.remove :university
	  t.remove :classification
	  t.remove :college
	  t.remove :department
	  t.remove :level
	  t.remove :grade
	  t.remove :lecture_num
	  t.remove :credit
	  t.remove :timetable
	  t.remove :location
	  t.references :shcool_id, foreign_key: true
	  t.references :professor_id, foreign_key: true
      t.references :past_course_id, foreign_key: true
    end
  end
end
