class CreateWeatherRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :weather_records do |t|
      t.float :temperature
      t.integer :humidity
      t.float :pressure

      t.timestamps
    end
  end
end
