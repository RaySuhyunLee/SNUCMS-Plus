class Course < ActiveRecord::Base
<<<<<<< HEAD
  has_many :issues, :as => :have_issue, dependent: :destroy 
  belongs_to :school
  belongs_to :professor

  has_one :next_course, :class_name => "Course", :foreign_key => "past_course_id"
  belongs_to :past_course, :class_name => "Course"

  # user subsription
  has_and_belongs_to_many :users
end
