class Issue < ActiveRecord::Base
	belongs_to :have_issue, :polymorphic => true
end
