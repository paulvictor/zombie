class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string "hospital_id"
      t.string "name"
      t.string "mode_of_death"
      t.string "gender"
      t.string "time_of_death"
      t.timestamps
    end
  end
end
