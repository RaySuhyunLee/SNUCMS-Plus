class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :contents
      t.string :commenter
      t.references :issue, index: true, foreign_key: true 

      t.timestamps null: false
    end
  end
end
