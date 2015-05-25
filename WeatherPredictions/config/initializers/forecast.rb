require 'open-uri'
require 'json'
require 'time'

scheduler = Rufus::Scheduler.new

def get_degree(text)
	if (deg <= 11.25)
		return "N"
	elsif (deg <= 33.75)
		return "NNE"
	elsif (deg <= 56.25)
		return "NE"
	elsif (deg <= 78.75)
		return "ENE"
	elsif (deg <= 101.25)
		return "E"
	elsif (deg <= 123.75)
		return "ESE"
	elsif (deg <= 146.25)
		return "SE"
	elsif (deg <= 168.75)
		return "SSE"
	elsif (deg <= 191.25)
		return "S"
	elsif (deg <= 213.75)
		return "SSW"
	elsif (deg <= 236.25)
		return "SW"
	elsif (deg <= 258.75)
		return "WSW"
	elsif (deg <= 281.25)
		return "W"
	elsif (deg <= 303.75)
		return "WNW"
	elsif (deg <= 326.25)
		return "NW"
	elsif (deg <= 348.75)
		return "NNW"
	elsif (deg <= 360)
		return "N"
	else
		return "-"
	end	
end

WeatherStations.each do |station|
	url = station.url
	doc = JSON.parse(open(url))
	data = doc["data"]
	data.each |point| do
		time = Time.parse(point["local_date_time_full"].to_i)
		precip = point[""]
		temp = point["air_temp"]
		text = point["wind_dir"]
		windDir = get_degree(text)
		windSpeed = ["wind_spd_kmh"]
		station.measurements.create(time: time, precipitation: precip, temperature: temp, wind_direction: windDir, wind_speed: windSpeed)	
	
	end
end
