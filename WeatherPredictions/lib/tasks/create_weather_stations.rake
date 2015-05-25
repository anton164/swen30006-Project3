namespace :app do
  desc "Create weather stations for Victoria"
  task :create_weather_stations => :environment do
    require 'open-uri'
    require 'nokogiri'
    BOM_PREFIX = "http://www.bom.gov.au/"
    page = Nokogiri::HTML(open("http://www.bom.gov.au/vic/observations/vicall.shtml"))
    page.css("#content table").each{|table|
      table.css("tbody tr th").each{|th| 
        location_page = Nokogiri::HTML(open(BOM_PREFIX + th.css('a')[0]["href"]))
        row = location_page.css("table.stationdetails tr")
        lat = row.css("td:eq(4)").text.gsub("Lat: ", "").strip!.to_f
        lon = row.css("td:eq(5)").text.gsub("Lon: ", "").strip!.to_f
        postal_code = Location.find_postal_code(lat, lon)
        if not postal_code.nil?
          WeatherStation.create({ 
            'name' => th.text,
            'lat' => lat,
            'lon' => lon,
            'postal_code' => postal_code,
            'json_url' => bom_prefix + locpage.css('p.noPrint')[1].css('a')[0]["href"]
          })
        end
      }
    } 
  end
end
