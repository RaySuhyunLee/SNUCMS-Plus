class Course < ActiveRecord::Base
  validates :title, presence: true
  validates :course_num, presence: true

  has_many :issues, :as => :have_issue, dependent: :destroy 
  belongs_to :professor

  # past_course linking
  has_one :next_course, :class_name => "Course", :foreign_key => "past_course_id"
  belongs_to :past_course, :class_name => "Course", :foreign_key => "past_course_id"

  # user subsription
  has_and_belongs_to_many :users

  has_many :crawl_logs, dependent: :destroy
end
