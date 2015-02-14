Rails.application.routes.draw do
  # root 'welcome#index'
    resources :restaurants do
      resources :reservations
    end
    resources :patrons

    put 'reservations/:id/add_time', :to => 'reservations#add_time'

    put 'reservations/:id/subtract_time', :to => 'reservations#subtract_time'
end
