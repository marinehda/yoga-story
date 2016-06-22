Rails.application.routes.draw do

  get 'payments/new'

  ActiveAdmin.routes(self)
  mount Attachinary::Engine => "/attachinary"

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope '(:locale)', locale: /fr|en/ do
    root to: 'pages#home'
    get '/lessons', to: 'pages#lessons', as: :all_lessons
    get '/teachers', to: 'pages#teachers', as: :all_teachers
    get '/list/:id', to: 'messages#list', as: :conversation

    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: [:show, :update] do
      #get '/list', to: 'messages#list', as: :conversation
    end
    resources :messages, only: [:index, :new, :create]

    resources :teachers, only: [:new, :update, :show] do
      resources :messages, only: [:create]
      member do
        get 'lessons'
      end
    end

    resources :bookings, only: [:edit, :update, :show] do
      resources :payments, only: [:new, :create]
        member do
          delete 'cancel'
        end
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
