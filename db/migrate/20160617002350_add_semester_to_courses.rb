class AddSemesterToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :semester, :string, { null: false, default: '1994-1' }
  end
end
