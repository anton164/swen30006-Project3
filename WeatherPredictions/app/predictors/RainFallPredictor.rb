#RainFallPredictor.rb

class RainFallPredictor < Predictor

	def initialize _name
		super _name
	end
	#issue, each station needs to know how far they are from the lat lon position and besorted from closest to furtherst away
	def predict _p
		rainfall_collection_of_points = Array.new
		_p.stations.each do |station|
			rainfall_points = Array.new
			weight = 1/station.distance_from_lat_lon
			station.measurements.each do |measurement|
				rainfall_points << measurement.rainfall * weight
			end
			rainfall_collection_of_points << rainfall_points
		end
		#Parse through the array of arrays and reduce it to a single dimension array
		
		regress rainfall_collection_of_points
	end

	private 

	def regress rainfall_points
		rainfall_points.each do |point|
			#regression work done here
		end
	end
end