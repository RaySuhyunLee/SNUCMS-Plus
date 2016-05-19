class Course < ActiveRecord::Base
  has_many :issues, :as => :have_issue, dependent: :destroy 
  belongs_to :school
  belongs_to :professor
end
