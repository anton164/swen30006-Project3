class AddJsonEndpointToWeatherStation < ActiveRecord::Migration
  def change
    add_column :weather_stations, :json_endpoint, :string
  end
end
