class UserIssueNum < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :issue_num
    end
  end
end
