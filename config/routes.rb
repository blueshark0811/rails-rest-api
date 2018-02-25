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
      resources :passwords, only: %i[create update]

      resources :groups do
        resources :group_users, only: %i[index create update destroy]
      end
      resources :courses
    end
  end

  root 'home#index'
end
