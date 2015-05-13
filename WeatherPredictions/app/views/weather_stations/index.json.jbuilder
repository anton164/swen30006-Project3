json.array!(@weather_stations) do |weather_station|
  json.extract! weather_station, :id, :postal_code, :lat, :lon
  json.url weather_station_url(weather_station, format: :json)
end
