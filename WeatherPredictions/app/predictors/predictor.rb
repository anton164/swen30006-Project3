#Predictor Class file

class Predictor
	attr_accessor :weather_feature

	def predict prediction	
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

	def time_probability time_until
		return 0.99
	end

	def distance_probability distance_km
		return 0.99
	end

	private 

	def calc_simple_regression arr_points
		x_axis = Array.new#(arr_points+1).size.times.collect{|i| i}.pop.to_scale
		y_axis = Array.new
		arr_points.each do |point|
			x_axis << point["timestamp"]
			y_axis << point["data"]
		end
		#points_sv = arr_points.to_scale
		sr = Statsample::Regression::simple(x_axis.to_scale,y_axis.to_scale)
		return sr

	end

end	