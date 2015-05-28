#Predictor Class file

class Predictor
	attr_accessor :weather_feature

	def predict prediction
		data_points = get_previous_data(prediction)
		regression_models = regress(data_points)
		station_predictions_aggregated = []
		# zip to iterate over the regression_model for each station
		regression_models.zip prediction.stations do |regression_model, station|
			station_predictions_aggregated << get_station_predictions(prediction, regression_model, station)
		end
		# Aggregate each station prediction by "time_until" and sum it
		aggregated_sums = station_predictions_aggregated.reduce(Hash.new(value: 0, probability: 0)) do |station_predictions, hash|
			station_predictions.each do |time_until, prediction| 
				hash[time_until][:value] += prediction[:value]
				hash[time_until][:probability] += prediction[:probability]
			end
			hash
		end

		# Add the average of the aggregated predictions and probabilities to the outputed data
		aggregated_sums.each do |time_until, prediction_sum|
			prediction.data["predictions"][time_until][@weather_feature] = {
				value: prediction_sum[:value]/station_predictions_aggregated.size,
				probability: prediction_sum[:probability]/station_predictions_aggregated.size
			}
		end

	end

	private 

	def regress data_points
		regression_models = []
		data_points.each do |point|
			regression_models << calc_simple_regression(point)
		end
		return regression_models
	end

	def get_previous_data prediction
		data_points = []
		prediction.stations.each do |station|
			station_points = []
			station.measurements.each do |measurement|
				station_points << {"data" => measurement.send(@weather_feature), "timestamp" => measurement.timestamp}
			end
			data_points << station_points
		end
		return data_points
	end

	def calc_simple_regression arr_points
		x_axis = Array.new
		y_axis = Array.new
		arr_points.each do |point|
			x_axis << point["timestamp"]
			y_axis << point["data"]
		end
		#points_sv = arr_points.to_scale
		sr = Statsample::Regression::simple(x_axis.to_scale,y_axis.to_scale)
		return sr

	end

	def time_probability time_until 
		# Decrease probability based on how long in the future the prediction is
		# >=180 minutes = 0.75 probability
		# 90 minutes = 0.875 probability
		# 0 minutes = 1.00 probability
		bound = 0.75
		return (time_until > 180) ? bound : (1 - (time_until/180.0)) * 0.25 + bound
	end

	def distance_probability distance_km
		# Decrease probability based on how far away the station is
		# >=400 km = 0.25 probability
		# 200 km = 0.625 probability
		# 0 km = 1.00 probability
		bound = 0.25
		return (distance_km > 400.0) ? 0.25 : (1 - (distance_km/400.0)) * 0.75 + 0.25
	end

end	