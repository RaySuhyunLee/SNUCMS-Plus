class AddIssueNumToCourse < ActiveRecord::Migration
  def change
    change_table :courses do |t|
	  t.integer :issue_num
	end
	change_table :issues do |t|
	  t.integer :parent_issue_id
	end
  end
end
