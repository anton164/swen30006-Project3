class TemperaturePredictor < Predictor

	def initialize 
		@weather_feature = "temperature"
	end
	
	def get_station_predictions (prediction, regression_model, station)
		station_predictions = {}
		distance = Geocoder::Calculations.distance_between(prediction.coordinates, [station.lat,station.lon], :units => :km)
		# Regress for each time_until (from prediction.now UNIX timestamp)
		(0..10).each do |i|
			time_until = i * prediction.period
			regression = regression_model.y(prediction.now + (time_until * 60))
			station_predictions[time_until] = {
				value: regression,
				probability: time_probability(time_until) * distance_probability(distance)
			}
		end
		return station_predictions
	end

end