Rails.application.routes.draw do

  get 'teachers/index'

  get 'teachers/show'

  get 'teachers/new'

  get 'teachers/create'

  get 'teachers/edit'

  get 'teachers/update'

  mount Attachinary::Engine => "/attachinary"

  devise_for :users, only: :omniauth_callbacks, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  scope '(:locale)', locale: /fr|en/ do
    devise_for :users, skip: :omniauth_callbacks
    resources :users, :teachers, :lessons, :bookings
    root to: 'pages#home'
  end

end
