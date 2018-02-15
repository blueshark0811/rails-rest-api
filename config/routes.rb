Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  namespace :api, defaults: { format: "json" } do
    namespace :v1 do

      resources :app_settings, only: [:index]

      resources :sessions, only: %i[create] do
        collection do
          match :destroy, via: %i[delete get]
        end
      end

      resources :users
      resources :registrations, only: [:create]
      resources :passwords, only: %i[create update] do
        member do
          post :update
        end
      end

      resources :groups
    end
  end

  root 'home#index'
end
