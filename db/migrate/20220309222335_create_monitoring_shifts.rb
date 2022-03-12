class CreateMonitoringShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :monitoring_shifts do |t|
      t.time :start_hour
      t.time :end_hour
      t.integer :duration
      t.references :user, null: false, foreign_key: true
      t.boolean :available, :default => false 
      t.date :date
      t.integer :week_number
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
