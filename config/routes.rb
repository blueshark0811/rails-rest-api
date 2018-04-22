require 'resque/server'

Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  if defined? Rswag
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  authenticate :user, -> (user) { user.super_admin? } do
    mount PgHero::Engine, at: "pghero"
    mount Resque::Server, at: '/jobs'
  end

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :organizations, only: %i[show update destroy]
      resources :organization_users, only: %i[create destroy]
      resources :states, only: %i[index show]
      resources :countries, only: %i[index show]
      resources :cities, only: %i[index show]
      resources :chats, except: %i[create] do
        collection do
          get 'with_opponent/:opponent_id', action: :with_opponent, as: :with_opponent
        end
        resources :chat_messages, only: %i[index create update destroy]
      end

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
      resources :passwords, only: %i[create] do
        collection do
          put :update
        end
      end

      resources :groups do
        resources :course_groups, only: %i[index create update destroy]

        resources :group_users, only: %i[index create update destroy] do
          collection do
            put :batch_update
          end
        end

        #for student/teacher
        resources :courses, only: %i[index show] do
          member do
            put :switch
          end
          resources :course_threads

          resources :lessons, only: %i[index show] do
            resources :tasks, only: %i[index show]
            member do
              put :complete
            end
          end
        end
      end

      #for admin...
      resources :courses do
        resources :lessons do
          resources :tasks
        end
      end

      scope ':notifiable_type/:notifiable_id' do
        resources :activities, only: %i[index update destroy]
      end

      scope ':commentable_type/:commentable_id' do
        resources :comments
      end

      scope ':attachmentable_type/:attachmentable_id' do
        resources :attachments
      end

      scope ':videoable_type/:videoable_id' do
        resources :videos do
          collection do
            post :get_token
          end
          member do
            post 'sproutvideo/:token', action: :sproutvideo, as: :sproutvideo
          end
        end
      end
    end
  end

  root 'home#index'
end
