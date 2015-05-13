class AddWeatherStationToLocation < ActiveRecord::Migration
  def change
    add_reference :locations, :weather_station, index: true
    add_foreign_key :locations, :weather_stations
  end
end
