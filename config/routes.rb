Rails.application.routes.draw do

  get 'bookings/index'

  get 'bookings/show'

  get 'bookings/new'

  get 'bookings/create'

  get 'bookings/edit'

  get 'bookings/update'

  ActiveAdmin.routes(self)
  mount Attachinary::Engine => "/attachinary"

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope '(:locale)', locale: /fr|en/ do
    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: [:show, :update]
    resources :teachers do
      member do
        get '/lessons', to: 'lessons#my_index', as: :my_lessons
      end
    end
    resources :lessons do
      member do
        get '/cancel', to: 'lessons#cancel', as: :cancel
      end
    end
    resources  :bookings
    root to: 'pages#home'
  end

end
