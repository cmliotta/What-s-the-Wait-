Rails.application.routes.draw do
  # root 'welcome#index'
    resources :restaurants do
      resources :reservations
    end
    resources :patrons

    put 'restaurants/:restaurant_id/reservations/add_time_1_or_2', :to => 'reservations#add_time_1_or_2'

    put 'restaurants/:restaurant_id/reservations/subtract_time_1_or_2', :to => 'reservations#subtract_time_1_or_2'

    put 'restaurants/:restaurant_id/reservations/add_time_3_or_4', :to => 'reservations#add_time_3_or_4'

    put 'restaurants/:restaurant_id/reservations/subtract_time_3_or_4', :to => 'reservations#subtract_time_3_or_4'
end
