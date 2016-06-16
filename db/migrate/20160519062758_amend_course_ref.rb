class AmendCourseRef < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.remove :school_id_id
	  t.remove :professor_id_id
	  t.remove :past_course_id_id
	  t.references :school, foreign_key: true
	  t.references :professor, foreign_key: true
	  t.references :past_course, foriegn_key: true
    end
  end
end
