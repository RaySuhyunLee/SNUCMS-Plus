class CreateIssuetags < ActiveRecord::Migration
  def change
    create_table :issuetags do |t|
      t.string :name

      t.timestamps null: false
    end

    create_table :issues_issuetags do |t|
      t.belongs_to :issuetags, index:true
      t.belongs_to :issues, index:true
    end
  end
end
