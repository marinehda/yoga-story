Rails.application.routes.draw do

  mount Attachinary::Engine => "/attachinary"

  scope '(:locale)', locale: /fr|en/ do
    devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
    resources :users, :teachers, :lessons, :bookings
    root to: 'pages#home'
  end

end
