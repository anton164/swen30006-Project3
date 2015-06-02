class DataController < ApplicationController

  # GET /weather/locations/
  def get_locations
    @date = Time.now.strftime("%d-%m-%Y")
    @stations = WeatherStation.all
    respond_to do |format|
      format.html { render :locations }
      format.json { render :locations }
    end
  end

  # GET /weather/data/:location_id/:date
  def get_by_id
    @station = WeatherStation.where(id: params[:location_id]).take
    if @station.nil?
      respond_to do |format|
        format.html { render :not_found }
        format.json { render :not_found }
      end
    else
      @date = params[:date]
      @current_temp = @station.current_temperature
      @current_cond = @station.current_conditions
      @measurements = @station.get_date_measurements(@date)
      respond_to do |format|
        format.html { render :location_id }
        format.json { render :location_id }
      end
    end
  end

  # GET /weather/data/:postal_code/:date
  def get_by_postal_code
    @stations = WeatherStation.where(:postal_code => params[:postal_code].to_i).to_a
    if @stations.size == 0
      respond_to do |format|
        format.html { render :not_found }
        format.json { render :not_found }
      end
    else
      @postal_code = params[:postal_code]
      @date = params[:date]
      respond_to do |format|
        format.html { render :locations_postal_code }
        format.json { render :locations_postal_code }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:postal_code, :date, :postal_code)
    end
end