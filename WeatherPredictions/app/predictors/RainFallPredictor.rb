#RainFallPredictor.rb

class RainFallPredictor < RainFallPredictor

	def initialize _name
		super _name
	end
	#issue, each station needs to know how far they are from the lat lon position and besorted from closest to furtherst away
	def predict _p
		fursthest_position = _p.stations[_p.stations.length-1].distance_from_location
		rainfall_points = Array.new
		_p.stations.each do |station|
			station.measurements.each do |measurement|
				measure
			end
		end
	end
end