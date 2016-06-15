class CreateIssuetags < ActiveRecord::Migration
  def change
    create_table :issuetags do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :issues_issuetags do |t|
      t.belongs_to :issuetag, index:true
      t.belongs_to :issue, index:true
    end
  end
end
