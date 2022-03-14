class CreateUserMonitoringShifts < ActiveRecord::Migration[6.0]
  def change
    create_table :user_monitoring_shifts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :monitoring_shift, null: false, foreign_key: true
      t.boolean :available, :default => false

      t.timestamps
    end
  end
end
