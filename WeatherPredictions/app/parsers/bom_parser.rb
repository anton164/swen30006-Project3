require 'time'

class BOMParser

  def get_degree(wind_direction)
    case wind_direction
    when "N"
      return 0
    when "NNE"
      return 22.5
    when "NE"
      return 45
    when "ENE"
      return 67.5
    when "E"
      return 90
    when "ESE"
      return 112.5
    when "SE"
      return 135
    when "SSE"
      return 157.5
    when "S"
      return 180
    when "SSW"
      return 202.5
    when "SW"
      return 225
    when "WSW"
      return 247.5
    when "W"
      return 270
    when "WNW"
      return 292.5
    when "NW"
      return 315
    when "NNW"
      return 337.5
    else
      return nil
    end
  end

  def calculate_rainfall(station, rainfall_since_9am, timestamp)
    timestamp_prev_hour = timestamp - 1 * 3600000
    # get latest measurement
    latest = station.measurements.order("timestamp DESC").first
    # check that it's not before 9 am
    return (latest.nil? || latest.timestamp.to_i < Time.parse("9:00am " + Time.at(timestamp).to_date.to_s).to_i || Time.at(timestamp).to_date != Time.at(latest.timestamp).to_date) ? rainfall_since_9am : rainfall_since_9am - latest.precipitation
  end

  def parse_measurements
    WeatherStation.all.each{|station|
      doc = JSON.parse(open(station.json_url).read)
      data = doc["observations"]["data"]
      # Reverse to start from the oldest point if we don't have any points from today
      if station.measurements.where(timestamp: (Time.now.to_date.to_time.to_i)..Time.now.to_i).empty?
        data = data.to_a.reverse
      end
      data.each { |point|
        puts point
        timestamp = Time.parse(point["local_date_time_full"]).to_i
        if station.measurements.where(timestamp: timestamp).empty?
          precip = calculate_rainfall(station, point["rain_trace"].to_f, timestamp)
          station.measurements.create(timestamp: timestamp, precipitation: precip, temperature: point["air_temp"].to_f, wind_direction: get_degree(point["wind_dir"]), wind_speed: point["wind_spd_kmh"].to_f)
        end
      }
    }
  end
end