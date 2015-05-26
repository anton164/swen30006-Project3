class Location

  attr_reader :coordinates

  def initialize (postal_code: nil, coordinates: nil)
    if not coordinates.nil?
      @coordinates = coordinates
      @postal_code = find_postal_code(coordinates[0], coordinates[1])
    elsif not postal_code.nil?
      @postal_code = postal_code
      @coordinates = find_coordinates(postal_code)
    end
  end

  def get_weather_stations
    ## First see if any weather_stations are in the postal code
    weather_stations = WeatherStation.where(:postal_code => @postal_code)
    if (weather_stations.size > 0)
      return weather_stations
    else
      ## Look for other weather_stations in close proximity
      buffer = 0.1
      while (weather_stations.size < 2)
        weather_stations = WeatherStation.where(:lat => @coordinates[0]-buffer..@coordinates[0]+buffer, 
          :long => @coordinates[1]-buffer..@coordinates[1]+buffer)
        buffer += 0.1
      end
  end

  def self.find_postal_code(lat, lon)
    address = Geocoder.address([lat, lon])
    match = address.match('(VIC|NSW) ([0-9]{4})')
    if not match.nil? and match.size == 3
      puts "Extracted postcode " + match[2] + " from address '" + address.to_s + "'"
      return match[2].to_i
    else
      puts "Warning: Skipped '" + address.to_s + "', can't extract postcode using GeoCoder"
    end
  end

  def self.find_coordinates(postal_code)
    return Geocoder.coordinates(postal_code.to_s + " VIC AUSTRALIA")
  end
end
