class Course < ActiveRecord::Base
  has_many :issues, :as => :have_issue, dependent: :destroy 
  belongs_to :school
  belongs_to :professor

  has_one :next_course, :class_name => "Course", :foreign_key => "past_course_id"
  belongs_to :past_course, :class_name => "Course"
end
