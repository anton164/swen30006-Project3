class PredictorFactory
  attr_accessor :weather_feature

  def self.create feature
    case feature
    when :rainfall
      return RainFallPredictor.new
    when :temperature
      return TemperaturePredictor.new
    when :wind_direction
      return WindDirectionPredictor.new
    when :wind_speed
      return WindSpeedPredictor.new
    end
  end

end 