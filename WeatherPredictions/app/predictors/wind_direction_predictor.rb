class WindDirectionPredictor < Predictor

  def initialize 
    @weather_feature = "wind_direction"
  end

  private 

  def get_station_predictions (prediction, regression_model, station)
    station_predictions = {}
    distance = Geocoder::Calculations.distance_between(prediction.coordinates, [station.lat,station.lon], :units => :km)
    # Regress for each time_until (from prediction.now UNIX timestamp)
    t = prediction.period / 10
    (0..t).each do |i|
      time_until = i * 10
      regression = regression_model.y(prediction.now + (time_until * 60))
      station_predictions[time_until] = {
        value: regression,
        probability: time_probability(time_until) * distance_probability(distance)
      }
    end
    return station_predictions
  end

end