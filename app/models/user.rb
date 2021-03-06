class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :subscribing_issues, class_name: "Issue"

  # User issues
  has_many :issues, :as => :have_issue, dependent: :destroy
end
