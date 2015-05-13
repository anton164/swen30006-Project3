class WeatherStation < ActiveRecord::Base
  has_many :measurements
  belongs_to :location
end
