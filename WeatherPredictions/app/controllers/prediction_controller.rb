class PredictionController < ApplicationController

  # GET /weather/prediction/:postal_code/:period
  def get_by_postal_code
    Location.new(params[:postal_code])
    weather_stations #array
    p = Prediction.new(weather_stations, params[:period], [:rainfall, :temperature, :wind_direction, :wind_speed])
    p.predict
    ## Create Output based on p.data
  end

  # GET /weather/prediction/:lat/:long/:period
  def get_by_lat_long
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:postal_code, :lat, :long, :period)
    end
end
