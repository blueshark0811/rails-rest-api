Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  
  # authenticate :user do
  #   mount Resque::Server, at: '/jobs'
  # end

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :sessions, only: %i[create] do
        collection do
          match :destroy, via: %i[delete get]
        end
      end

      resources :users do
        member do
          post :send_set_password_link
        end
      end
      resources :registrations, only: [:create]
      resources :passwords, only: %i[create update]

      resources :groups do
        resources :course_groups, only: %i[index create update destroy] 

        resources :group_users, only: %i[index create update destroy] do
          collection do
            put :batch_update
          end
        end
      end
      resources :courses do
        resources :lessons
      end

      scope ':attachmentable_type/:attachmentable_id' do
        resources :attachments
      end

      scope ':videoable_type/:videoable_id' do
        resources :videos
      end
    end
  end

  root 'home#index'
end
