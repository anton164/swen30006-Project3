class TemperaturePredictor < Predictor

	def initialize 
		@weather_feature = "temperature"
	end
	#issue, each station needs to know how far they are from the lat lon position and besorted from closest to furtherst away
	def predict _p
		temperature_collection_of_points = Array.new
		_p.stations.each do |station|
			temperature_points = Array.new
			station.measurements.each do |measurement|
				temperature_points << measurement.temperature
			end
			temperature_collection_of_points << temperature_points
		end
		regress rainfall_points
	end

	private 

	def regress rainfall_points
		rainfall_points.each do |point|
			#regression work done here
		end
	end
end