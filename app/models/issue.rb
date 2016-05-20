class Issue < ActiveRecord::Base
	validates :title, presence: :true
	belongs_to :have_issue, :polymorphic => true
	has_many :comments, dependent: :destroy

  has_and_belongs_to_many :users

	accepts_nested_attributes_for :comments
end
