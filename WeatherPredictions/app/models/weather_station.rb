class WeatherStation < ActiveRecord::Base
  has_many :measurements
end
