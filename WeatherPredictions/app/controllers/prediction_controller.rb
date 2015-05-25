class PredictionController < ApplicationController

  # GET /weather/prediction/:postal_code/:period
  def get_by_postal_code
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
