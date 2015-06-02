class AddWeatherstationsToMeasurements < ActiveRecord::Migration
  def change
    add_reference :measurements, :weather_station, index: true
    add_foreign_key :measurements, :weather_stations
  end
end
