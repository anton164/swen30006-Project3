require 'forecast_io'
require 'time'
ForecastIO.api_key = '811a6d564ecf0a130c1becb4ec00ee6c'

class WeatherStation < ActiveRecord::Base
  has_many :measurements

  def get_data_at_time(time)
    forecast = ForecastIO.forecast(self.lat, self.lon, time: time.to_i)
    data = forecast.data.hourly
    data.each do |point|
      measurement = self.measurements.create(condition: point.icon.to_s, time: Time.parse(point.time), temperature: point.temperature, 
        wind_direction: point.windDirection, wind_speed: point.windSpeed, precipitation: point.precipIntensity)
      measurement.save
    end
  end

  def get_data_at_date(date)
  	time = Date.parse(date)
  	get_data_at_time(time)
  end

  def get_recent()
  	time = Time.now
    forecast = ForecastIO.forecast(self.lat, self.lon, time: time.to_i - 3600)
    data = forecast.data.minutely
    data.each do |point|
      measurement = self.measurements.create(condition: point.icon.to_s, time: Time.parse(point.time), temperature: point.temperature, 
        wind_direction: point.windDirection, wind_speed: point.windSpeed, precipitation: point.precipIntensity)
      measurement.save
    end
  end

  def get_current()
    time = Time.now
    forecast = ForecastIO.forecast(self.lat, self.lon, time: time.to_i)
    data = forecast.data.currently
    data.each do |point|
      measurement = self.measurements.create(condition: point.icon.to_s, time: Time.parse(point.time), temperature: point.temperature, 
        wind_direction: point.windDirection, wind_speed: point.windSpeed, precipitation: point.precipIntensity)
      measurement.save
    end
  end

  def round_to_hour(time)
    extra = time%3600 
    return time - extra
  end

  def round_to_day(time)
    extra = time%86400
    return time - extra
  end

end
