class DataController < ApplicationController

  # GET /weather/locations/
  def get_locations
  end

  # GET /weather/data/:location_id/:date
  def get_by_location
  end

  # GET /weather/data/:postal_code/:date
  def get_by_postal_code
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:postal_code, :date, :postal_code)
    end
end