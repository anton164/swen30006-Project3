Rails.application.routes.draw do
  
  scope(:path => '/weather') do
    get '/locations',
      :controller => 'data',
      :as => "locations",
      :action => "get_locations"

    resources :data, :only => [] do
      collection do
        get ':postal_code/:date', 
          :constraints => { :postal_code => /\d{4}/, :date => /\d{2}-\d{2}-\d{4}/ },
          :as => "data_by_postal_code_date",
          :action => "get_by_postal_code"
        get ':location_id/:date', 
          :constraints => { :date => /\d{2}-\d{2}-\d{4}/ },
          :as => "data_by_id_date",
          :action => "get_by_location"
      end
    end

    resources :prediction, :only => [] do
      collection do
        get ':postal_code/:period', 
          :constraints => { :postal_code => /\d{4}/},
          :as => "prediction_by_postal_code",
          :action => "get_by_postal_code"
        get ':lat/:long/:period', 
          :as => "prediction_by_lat_long",
          :action => "get_by_lat_long"
      end
    end
  end

end
