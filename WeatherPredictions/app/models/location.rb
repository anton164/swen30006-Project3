class Location < ActiveRecord::Base
  has_many :weather_stations
end
