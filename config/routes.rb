Rails.application.routes.draw do

  ActiveAdmin.routes(self)
  mount Attachinary::Engine => "/attachinary"

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope '(:locale)', locale: /fr|en/ do
    root to: 'pages#home'
    get '/lessons', to: 'pages#lessons', as: :all_lessons
    get '/teachers', to: 'pages#teachers', as: :all_teachers

    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: [:show, :update]

    resources :teachers, only: [:new, :update, :show] do
      member do
        get 'lessons'
      end
    end

    resources :bookings, only: [:edit, :update, :show] do
      member do
        get 'cancel'
      end
      collection do
        get 'my_teacher_index'
        get 'my_student_index'
      end
    end

    resources :lessons, only: [:show, :new, :create, :edit, :update] do
      member do
        get 'cancel'
      end
      resources :bookings, only: [:new, :create]
    end
  end
end
