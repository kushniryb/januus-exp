Rails.application.routes.draw do
  root 'tickets#index'

  resources :tickets, only: %i[index show]

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :tickets, only: :create
    end
  end
end
