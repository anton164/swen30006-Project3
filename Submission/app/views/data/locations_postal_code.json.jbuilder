json.date(@date)
json.locations do
  json.array!(@stations) do |station|
    json.id(station.id)
    json.lat(station.lat)
    json.lon(station.lon)
    json.last_update(Time.at(station.last_measurement.timestamp).strftime("%H:%M %d-%m-%Y"))
    json.measurements do
      json.array!(station.get_date_measurements(@date).sort!{|x,y| y.timestamp <=> x.timestamp}) do |measurement|
        json.time(Time.at(measurement.timestamp).strftime("%H:%M"))
        json.temp(measurement.temperature)
        json.precip(measurement.precipitation)
        json.wind_direction(measurement.format_wind_direction)
        json.wind_speed(measurement.wind_speed)
      end
    end
  end
end