namespace :app do
  desc "Create weather stations for Victoria"
  task :create_weather_stations => :environment do
    require 'open-uri'
    require 'nokogiri'
    page = Nokogiri::HTML(open("http://www.bom.gov.au/vic/observations/vicall.shtml"))
    page.css("#content table").each{|table|
      table.css("tbody tr th").each{|th| 
        location_page = Nokogiri::HTML(open("http://www.bom.gov.au/" + th.css('a')[0]["href"]))
        row = location_page.css("table.stationdetails tr")
        lat = row.css("td:eq(4)").text.gsub("Lat: ", "").strip!.to_f
        lon = row.css("td:eq(5)").text.gsub("Lon: ", "").strip!.to_f
        WeatherStation.create({ 
          'name' => th.text,
          'lat' => lat,
          'lon' => lon,
          'postal_code' => Location.find_postal_code(lat, lon)
        })
      }
    } 
  end
end
