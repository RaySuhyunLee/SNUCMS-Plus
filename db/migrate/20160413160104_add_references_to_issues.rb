class AddReferencesToIssues < ActiveRecord::Migration
  def change
  	change_table :issues do |t|
	  t.references :have_issue, :polymorphic => true
	end
  end
end
