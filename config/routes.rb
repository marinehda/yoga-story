Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope '(:locale)', locale: /fr|en/ do
    devise_for :users, skip: :omniauth_callbacks
    resources :users, only: [:show, :update]

    resources :teachers
    resources :lessons
    resources  :bookings
    root to: 'pages#home'
  end

end
