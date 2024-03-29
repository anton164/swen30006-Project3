json.date(@date)
json.stations do
  json.array!(@stations) do |station|
    json.id(station.id)
    json.lat(station.lat)
    json.lon(station.lon)
    json.last_update(Time.at(station.last_measurement.timestamp).strftime("%H:%M%P %d-%m-%Y"))
  end
end