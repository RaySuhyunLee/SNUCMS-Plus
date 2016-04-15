class Issue < ActiveRecord::Base
	validates :title, presence: :true
	belongs_to :have_issue, :polymorphic => true
	has_many :comments, dependent: :destroy
end
