class Prediction

  attr_reader :period, :stations
  attr_accessor :data

  def initialize(weather_stations, period, predictors)
    @stations = weather_stations
    @period = period
    @data = {}
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
