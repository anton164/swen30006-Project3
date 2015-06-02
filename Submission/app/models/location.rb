class Location

  attr_reader :coordinates, :postal_code, :city

  def initialize (postal_code: nil, coordinates: nil)
    if not coordinates.nil?
      @coordinates = coordinates
      @postal_code = self.class.find_postal_code(coordinates[0], coordinates[1])
    elsif not postal_code.nil?
      @postal_code = postal_code
      @coordinates = self.class.find_coordinates(postal_code)
    end
    @city = Geocoder.search(@coordinates)[0].city
  end

  def get_weather_stations
    ## First see if any weather_stations are in the postal code
    weather_stations = WeatherStation.where(:postal_code => @postal_code).to_a
    if (weather_stations.size > 0)
      return weather_stations
    else
      ## Look for other weather_stations in close proximity
      buffer = 0.1
      while (weather_stations.size < 2)
        weather_stations += WeatherStation.where(:lat => @coordinates[0]-buffer..@coordinates[0]+buffer, 
          :lon => @coordinates[1]-buffer..@coordinates[1]+buffer).to_a
        buffer += 0.1
      end
      return weather_stations
    end
  end

  def self.find_postal_code(lat, lon)
    return Geocoder.search([lat, lon])[0].postal_code.to_i
  end

  def self.find_coordinates(postal_code)
    return Geocoder.coordinates(postal_code.to_s + " VIC AUSTRALIA")
  end
end
