class PredictionController < ApplicationController
  # layout "prediction/show"
  # GET /weather/prediction/:postal_code/:period
  def get_by_postal_code
    loc = Location.new(postal_code: params[:postal_code])
    get_predictions(loc)
  end

  # GET /weather/prediction/:lat/:long/:period
  def get_by_lat_lon
    loc = Location.new(coordinates: [params[:lat].to_f, params[:lon].to_f])
    get_predictions(loc)
  end

  private
    def get_predictions(loc)
      weather_stations = loc.get_weather_stations
      p = Prediction.new(loc.coordinates, weather_stations, params[:period].to_i, [:rainfall, :wind_speed, :temperature, :wind_direction])
      p.predict
      render_predictions(p, loc)
    end

    def prepare_data(data)
      ## Prepare data to meet spec key-name requirements
      rename = { "precipitation" => "rain", "temperature" => "temp" }
      data["predictions"].each do |time, prediction| 
        prediction.keys.each do |key|
          data["predictions"][time][rename[key]] = data["predictions"][time].delete(key) if rename[key]
        end
      end
      data
    end

    def render_predictions(predictions, loc)
      @data = predictions.data
      @now = predictions.now
      @loc = loc
      puts @data
        respond_to do |format|
          format.html { render :show }
          format.json { render :show, data: prepare_data(@data)}
      end
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:postal_code, :lat, :long, :period)
    end
end
