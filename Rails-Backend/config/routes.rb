Rails.application.routes.draw do
  get 'patron/create'

  get 'patron/update'

  get 'restaurant/create'

  get 'restaurant/update'

  # root 'welcome#index'
    resources :restaurants do
      resources :reservations
    end
    resources :patrons
end
