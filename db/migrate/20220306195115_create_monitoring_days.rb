class CreateMonitoringDays < ActiveRecord::Migration[6.0]
  def change
    create_table :monitoring_days do |t|
      t.references :contract, null: false, foreign_key: true
      t.references :weekday_setup, null: false, foreign_key: true

      t.timestamps
    end
  end
end
