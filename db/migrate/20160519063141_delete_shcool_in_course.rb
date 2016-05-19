class DeleteShcoolInCourse < ActiveRecord::Migration
  def change
    change_table :courses do |t|
	  t.remove :shcool_id_id
	end
  end
end
