Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  mount Attachinary::Engine => "/attachinary"

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope '(:locale)', locale: /fr|en/ do
    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: [:show, :update]
    resources :teachers, only: [:new, :update, :show] do
      member do
        get '/lessons', to: 'lessons#my_index', as: :my_lessons
      end
    end
    resources :lessons, except: [:index, :destroy] do
      member do
        get '/cancel', to: 'lessons#cancel', as: :cancel
      end
    end
    resources  :bookings
    root to: 'pages#home'
    get '/lessons', to: 'pages#lessons', as: :all_lessons
    get '/teachers', to: 'pages#teachers', as: :all_teachers
  end

end
