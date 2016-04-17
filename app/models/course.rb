class Course < ActiveRecord::Base
  has_many :issues, :as => :have_issue, dependent: :destroy
end
