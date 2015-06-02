json.date(@date)
json.current_temp(@current_temp)
json.current_cond(@current_cond)
json.measurements do
  json.array!(@measurements.sort!{|x,y| y.timestamp <=> x.timestamp}) do |measurement|
    json.time(Time.at(measurement.timestamp).strftime("%H:%M"))
    json.temp(measurement.temperature)
    json.precip(measurement.precipitation)
    json.wind_direction(measurement.format_wind_direction)
    json.wind_speed(measurement.wind_speed)
  end
end