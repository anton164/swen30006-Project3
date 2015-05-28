require 'time'

class WeatherStation < ActiveRecord::Base
  has_many :measurements

  def get_date_measurements(date)
    measurements.where(timestamp: (Time.parse(date).to_i)..(Time.parse(date) + 1.day).to_i).to_a
  end

  def current_temperature
    if (last_measurement.timestamp > (Time.now.to_i - 30 * 60))
      last_measurement.temperature
    else 
      return nil
    end
  end

  def current_conditions
    if (last_measurement.timestamp > (Time.now.to_i - 30 * 60))
      if (last_measurement.precipitation > 0)
        return (last_measurement.temperature <= 0) ? "snowing" : "raining"
      elsif (last_measurement.precipitation == 0)
        return "sunny/cloudy"
      end
    else 
      return nil
    end
  end

  def last_measurement
    measurements.order("timestamp DESC").first
  end

  def round_to_hour(time)
    extra = time%3600 
    return time - extra
  end

end
