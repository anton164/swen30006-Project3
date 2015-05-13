json.array!(@measurements) do |measurement|
  json.extract! measurement, :id, :condition, :time, :precitipation, :wind_direction, :wind_speed, :temperature
  json.url measurement_url(measurement, format: :json)
end
