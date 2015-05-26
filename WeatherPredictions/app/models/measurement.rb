class Measurement < ActiveRecord::Base
  belongs_to :weather_station
  def self.closest_in_time(timestamp)
    order("abs(weather_records.timestamp - #{timestamp})")
  end
end
