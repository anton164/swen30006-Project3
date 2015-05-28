class Measurement < ActiveRecord::Base
  belongs_to :weather_station
  def self.closest_in_time(timestamp)
    order("abs(weather_records.timestamp - #{timestamp})")
  end
  def format_wind_direction
    if (self.wind_direction.nil?)
      return "CALM"
    end
    if (self.wind_direction >= 348.75 or self.wind_direction < 11.25)
      return "N"
    elsif (self.wind_direction >= 326.25)
      return "NNW"
    elsif (self.wind_direction >= 303.75)
      return "NW"
    elsif (self.wind_direction >= 281.25)
      return "WNW"
    elsif (self.wind_direction >= 258.75)
      return "W"
    elsif (self.wind_direction >= 236.25)
      return "WSW"
    elsif (self.wind_direction >= 213.75)
      return "SW"
    elsif (self.wind_direction >= 191.25)
      return "SSW"
    elsif (self.wind_direction >= 168.75)
      return "S"
    elsif (self.wind_direction >= 146.25)
      return "SSE"
    elsif (self.wind_direction >= 123.75)
      return "SE"
    elsif (self.wind_direction >= 101.25)
      return "ESE"
    elsif (self.wind_direction >= 78.75)
      return "E"
    elsif (self.wind_direction >= 56.25)
      return "ENE"
    else
      return "NE"
    end
  end
end
