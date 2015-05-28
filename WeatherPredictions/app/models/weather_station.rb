require 'forecast_io'
require 'time'
ForecastIO.api_key = '811a6d564ecf0a130c1becb4ec00ee6c'

class WeatherStation < ActiveRecord::Base
  has_many :measurements

  #dates must be passed as strings in the form of DD/MM/YYYY
  def get_date(date)
  	time = Date.parse(date)
    forecast = ForecastIO.forecast(self.lat, self.lon, time: time.to_i)
    data = forecast.data.hourly
    data.each do |point|
      measurement = self.measurements.create(condition: point.icon.to_s, time: Time.parse(point.time), temperature: point.temperature, 
        wind_direction: point.windDirection, wind_speed: point.windSpeed, precipitation: point.precipIntensity)
      measurement.save
    end
  end

  def last_update
    measurements.order("timestamp DESC").first.timestamp
  end 

  def round_to_hour(time)
    extra = time%3600 
    return time - extra
  end

end
