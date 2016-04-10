class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :student_id
      t.string :college
      t.string :major

      t.timestamps null: false
    end
  end
end
