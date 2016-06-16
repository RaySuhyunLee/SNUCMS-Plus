class Issue < ActiveRecord::Base
  validates :title, presence: :true
  belongs_to :have_issue, :polymorphic => true
  has_many :comments, dependent: :destroy

  # issue subscribtion
  has_and_belongs_to_many :users

  # issue tagging
  has_and_belongs_to_many :issuetags

  accepts_nested_attributes_for :comments

  def start_time
    due
  end
end
