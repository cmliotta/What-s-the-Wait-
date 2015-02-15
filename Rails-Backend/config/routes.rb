Rails.application.routes.draw do
  # root 'welcome#index'
    resources :restaurants do
      resources :reservations
    end
    resources :patrons

    post 'restaurants/:restaurant_id/reservations/add_time', :to => 'reservations#add_time'

    post 'restaurants/:restaurant_id/reservations/subtract_time', :to => 'reservations#subtract_time'
end
