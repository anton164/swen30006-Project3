#RainFallPredictor.rb

class RainFallPredictor < Predictor

	def initialize 
		@weather_feature = "rainfall_amount"
	end
	#issue, each station needs to know how far they are from the lat lon position and besorted from closest to furtherst away
	def predict _p
		rainfall_collection_of_points = Array.new
		_p.stations.each do |station|
			rainfall_points = Array.new
			#weight = 1/station.distance_from_lat_lon
			station.measurements.each do |measurement|
				rainfall_points << {"data" => measurement.percipitation, "time_stamp" => measurement.time.to_time.to_i}# * weight
			end
			rainfall_collection_of_points << rainfall_points
		end
		#Parse through the array of arrays and reduce it to a single dimension array
		sr_for_each_station = regress rainfall_collection_of_points
		output_data = Array.new
		collection_pred_val = Array.new
		sr_for_each_station.zip _p.stations do |station_sr, station|
			#zip iterates over two arrays
			#station_sr = station simple regression
			#station = WeatherStation
=begin
			get the distance from _p.coordinates[lat,lon] for this particular station
				weight
			multiply the 10 future values by weight and store in prediction_values[10]
			add rediction_value to collection_pred_val
=end
			weight = 1/Geocoder::Calculations.distance_between(_p.coordinates, [station.lat,station.lon], :units => :km)
			time_dis = _p.now +(_p.period*60)
			prediction_values = Array.new
			(0..10).each {|i|
				prediction_values << station_sr.y(_p.now + (_p.period * 60 * i))*weight
			}
			collection_pred_val << prediction_values
		end

		collection_pred_val.each do |item|
			value = item.reduce :+
			output_data << value/11
		end	
		_p.data["prediction"][@weather_feature] => output_data 
		#fill outputdata with a new array of 10
		#loop through collection_pred_val, use element.reduce
	end

	private 

	def regress rainfall_points
		# first predict over each individual station
		collection_of_regression_models = Array.new
		rainfall_points.each do |point|
			#regression work done here
			collection_of_regression_models << calc_simple_regression point
		end
	end


	end
end