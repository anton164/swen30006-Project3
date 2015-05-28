class Prediction

  attr_reader :period, :stations, :now, :coordinates
  attr_accessor :data

  def initialize(coordinates, weather_stations, period, predictors)
    @stations = weather_stations
    @period = period
    @data = {
      "latitude" => coordinates[0],
      "longitude" => coordinates[1],
      "predictions" => {}
    }
    @now = Time.new.to_i
    (0..10).each { |i|
      time_until = i * period
      @data["predictions"][time_until] = Hash.new
      # To-DO: populate "time" as well
    }
    @coordinates = coordinates
    @predictors = []
    predictors.each { |predictor| 
      @predictors << PredictorFactory.create(predictor)
    }
  end

  def predict
    @predictors.each { |predictor|
      predictor.predict(self)
    }
  end

end
