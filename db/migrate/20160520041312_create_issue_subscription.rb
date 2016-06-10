class CreateIssueSubscription < ActiveRecord::Migration
  def change
    create_table :issues_users do |t|
      t.belongs_to :issue, index: true
      t.belongs_to :user, index: true
    end
  end
end
