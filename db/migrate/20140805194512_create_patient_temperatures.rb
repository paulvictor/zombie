class CreatePatientTemperatures < ActiveRecord::Migration
  def change
    create_table :patient_temperatures do |t|
      t.references :patient
      t.float :sampling_time
      t.float :temperature
    end
  end
end
