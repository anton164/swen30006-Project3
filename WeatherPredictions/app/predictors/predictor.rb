#Predictor Class file

class Predictor
	attr_accessor :weather_feature

	def initialize
		#@weather_feature = _name
	end

	def predict _p	
	end

	private 

	def calc_simple_regress arr_points
		x_axis = Array.new#(arr_points+1).size.times.collect{|i| i}.pop.to_scale
		y_axis = Array.new
		arr_points.each do |point|
			x_axis << point["time_stamp"]
			y_axis << point["data"]
		end
		#points_sv = arr_points.to_scale
		sr = Statsample::Regression::simple(x_axis.to_scale,y_axis.to_scale)
		return sr

	end

end	