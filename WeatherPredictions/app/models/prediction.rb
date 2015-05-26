class Prediction

  attr_reader :period, :stations, :now
  attr_accessor :data

  def initialize(coordinates, weather_stations, period, predictors)
    @stations = weather_stations
    @period = period
    @data = {
      "lattitude" => coordinates[0],
      "longitude" => coordinates[1]
      "predictions" => {}
    }
    @coordinates = coordinates
    @predictors = []
    predictors.each { |predictor| 
      @predictors << PredictorFactory.create(predictor)
    }
    @now = Time.new.to_i
  end

  def predict
    @predictors.each { |predictor|
      predictor.predict(self)
    }
  end
end
