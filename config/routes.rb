Rails.application.routes.draw do
  root to: 'pages#home'
  resources :symptoms, except: [:index]
  devise_for :users, :controllers => {:omniauth_callbacks => "callbacks"}
end
