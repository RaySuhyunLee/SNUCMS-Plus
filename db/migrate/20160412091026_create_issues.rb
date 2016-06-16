class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :title	# 이슈 제목
      t.text :contents	# 이슈 내용

      t.timestamps null: false
    end
  end
end
