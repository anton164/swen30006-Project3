require 'forecast_io'
require 'time'
ForecastIO.api_key = '811a6d564ecf0a130c1becb4ec00ee6c'

class WeatherStation < ActiveRecord::Base
  has_many :measurements

  def get_date(date)
  	time = Date.parse(date)
  	forecast = ForecastIO.forecast(self.lat, self.lon, time: time.to_i)
  	data = forecast.hourly
  	data.each do |point|
  	measurement = self.measurements.create(time: Time.parse(point.time), temperature: point.temperature, 
  		wind_direction: point.windDirection, wind_speed: point.windSpeed, precipitation: point.precipIntensity)
  	measurement.save

  end
end
