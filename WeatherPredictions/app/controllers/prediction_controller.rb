class PredictionController < ApplicationController

  # GET /weather/prediction/:postal_code/:period
  def get_by_postal_code
    loc = Location.new(postal_code: params[:postal_code])
    weather_stations = loc.get_weather_stations
    p = Prediction.new(loc.coordinates, weather_stations, params[:period].to_i, [:rainfall])
    puts "PREDICT NOW"
    p.predict
    puts "PREDICTED"
    ## Output based on p.data
  end

  # GET /weather/prediction/:lat/:long/:period
  def get_by_lat_long
    loc = Location.new(coordinates: [params[:lat].to_f, params[:long].to_f])
    weather_stations = loc.get_weather_stations
    p = Prediction.new(loc.coordinates, weather_stations, params[:period], [:rainfall, :temperature, :wind_direction, :wind_speed])
    p.predict
    ## Output based on p.data
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:postal_code, :lat, :long, :period)
    end
end
