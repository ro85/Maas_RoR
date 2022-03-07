class CreateWeekdaySetups < ActiveRecord::Migration[6.0]
  def change
    create_table :weekday_setups do |t|
      t.references :weekday, null: false, foreign_key: true
      t.time :start_of_monitoring
      t.time :end_of_monitoring
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
