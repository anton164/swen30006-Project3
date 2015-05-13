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
        WeatherStation.create({ 
          'name' => th.text,
          'lat' => row.css("td:eq(4)").text.gsub("Lat: ", "").strip!.to_f,
          'lon' => row.css("td:eq(5)").text.gsub("Lon: ", "").strip!.to_f
        })
      }
    } 
  end
end
