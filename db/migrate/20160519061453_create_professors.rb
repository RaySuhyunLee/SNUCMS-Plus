class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :name
      t.text :picture
      t.timestamps null: false
    end
  end
end
