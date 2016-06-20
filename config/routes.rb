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
    get '/bookings/my_teacher_index', to: 'bookings#my_teacher_index', as: :my_teacher_index
    get '/bookings/my_student_index', to: 'bookings#my_student_index', as: :my_student_index
    resources :lessons, only: [:show, :new, :create, :edit, :update] do
      member do
        get '/cancel', to: 'lessons#cancel', as: :cancel
      end
      resources :bookings, only: [:new, :create]
    end
    #resources  :bookings, only: [:index]
    root to: 'pages#home'
    get '/lessons', to: 'pages#lessons', as: :all_lessons
    get '/teachers', to: 'pages#teachers', as: :all_teachers
    get '/bookings/:id', to: 'bookings#cancel', as: :cancel_booking

  end

end
