Rails.application.routes.draw do

  root 'tickets#index'
  resources :tickets, only: [:index, :show]

  namespace :api do
    defaults format: :json do
      resources :tickets, only: [:create]
    end
  end
end
