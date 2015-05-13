class Location
  def self.find_postal_code(lat, lon)
    match = Geocoder.address([-36.28,143.33]).match('([0-9]{4}), Australia')
    if (match.size == 2)
      return match[1].to_i
    end
  end
end
