class CreateContracts < ActiveRecord::Migration[6.0]
  def change
    create_table :contracts do |t|
      t.string :client_name
      t.date :start_date
      t.date :end_date
      t.time :monday_start_hour
      t.time :monday_end_hour
      t.time :tuesday_start_hour
      t.time :tuesday_end_hour
      t.time :wednesday_start_hour
      t.time :wednesday_end_hour
      t.time :thursday_start_hour
      t.time :thursday_end_hour
      t.time :friday_start_hour
      t.time :friday_end_hour
      t.time :saturday_start_hour
      t.time :saturday_end_hour
      t.time :sunday_start_hour
      t.time :sunday_end_hour
      t.float :price_per_hour
      
      t.timestamps
    end
  end
end
