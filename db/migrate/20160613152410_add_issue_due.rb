class AddIssueDue < ActiveRecord::Migration
  def change
    change_table :issues do |t|
      t.datetime :due
    end
  end
end
