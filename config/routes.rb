Rails.application.routes.draw do

  get 'bookings/my_teacher_index'
  get 'bookings/my_student_index'

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
    resources :lessons, only: [:show, :new, :create, :edit, :update, :index] do
      resources :bookings, only: [:new, :create]
      member do
        get '/cancel', to: 'lessons#cancel', as: :cancel
      end
    end
    resources  :bookings, only: [:index]
    root to: 'pages#home'
    get '/lessons', to: 'pages#lessons', as: :all_lessons
    get '/teachers', to: 'pages#teachers', as: :all_teachers
  end

end
