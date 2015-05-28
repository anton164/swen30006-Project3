class RainfallPredictor < Predictor

	def initialize 
		@weather_feature = "precipitation"
	end
	

	def predict prediction

		rainfall_points = get_previous_data(prediction)
		regression_models = regress(rainfall_points)
		station_predictions_aggregated = []
		# zip to iterate over the regression_model for each station
		regression_models.zip prediction.stations do |regression_model, station|

			distance = Geocoder::Calculations.distance_between(prediction.coordinates, [station.lat,station.lon], :units => :km)
			distance_weight = 100 / distance
			station_predictions = {}
			# Regress for each time_until (from prediction.now UNIX timestamp)
			(0..10).each do |i|
				time_until = i * prediction.period
				regression = regression_model.y(prediction.now + (time_until * 60))
				station_predictions[time_until] = {
					value: regression == 0 ? regression : regression * distance_weight,
					probability: time_probability(time_until) * distance_probability(distance)
				}
			end
			# Add every regression (11 with different time_untils) to the aggregated station predictions
			station_predictions_aggregated << station_predictions
		end

		# Aggregate each station prediction by "time_until" and sum it
		aggregated_sums = station_predictions_aggregated.reduce(Hash.new(value: 0, probability: 0)) do |station_predictions, hash|
			station_predictions.each do |time_until, prediction| 
				hash[time_until][:value] += prediction[:value]
				hash[time_until][:probability] += prediction[:probability]
			end
			return hash
		end

		# Add the average of the aggregated predictions and probabilities to the outputed data
		aggregated_sums.each do |time_until, prediction_sum|
			prediction.data["predictions"][time_until][@weather_feature] = {
				value: prediction_sum[:value]/11,
				probability: prediction_sum[:probability]/11
			}
		end

		puts "PREDICTION COMES HERE"
		puts prediction.data["predictions"]
	end

	private 

	def regress rainfall_points
		# first predict over each individual station
		regression_models = []
		rainfall_points.each do |point|
			regression_models << calc_simple_regression(point)
		end
		return regression_models
	end

end