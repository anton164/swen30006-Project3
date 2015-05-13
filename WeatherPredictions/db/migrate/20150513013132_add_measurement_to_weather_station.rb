class AddMeasurementToWeatherStation < ActiveRecord::Migration
  def change
    add_reference :weather_stations, :measurement, index: true
    add_foreign_key :weather_stations, :measurements
  end
end
