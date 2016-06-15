class AssociateCoursesToProfessors < ActiveRecord::Migration
  def change
    change_table :courses do |t|
      t.belongs_to :professor, index: true
    end
  end
end
