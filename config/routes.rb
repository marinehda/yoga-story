Rails.application.routes.draw do

  get 'lessons/index'

  get 'lessons/new'

  get 'lessons/create'

  get 'lessons/edit'

  get 'lessons/update'

  mount Attachinary::Engine => "/attachinary"

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope '(:locale)', locale: /fr|en/ do
    devise_for :users, skip: :omniauth_callbacks
    resources :users, :teachers, :lessons, :bookings
    root to: 'pages#home'
  end

end
