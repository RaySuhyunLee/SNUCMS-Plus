class RemoveContentsFromIssues < ActiveRecord::Migration
  def change
		change_table :issues do |t|
			t.remove :contents
		end
  end
end
