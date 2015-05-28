json.date(@date)
json.stations do
  json.array!(@locations) do |station|
    json.id(station.id)
    json.lat(station.lat)
    json.lon(station.lon)
    json.last_update(Time.at(station.measurements.order("timestamp DESC").first.timestamp).strftime("%H:%M%P %d-%m-%Y"))
  end
end