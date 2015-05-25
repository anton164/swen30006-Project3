class Location
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
