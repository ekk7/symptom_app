Rails.application.routes.draw do
  root to: 'pages#home'
  resources :symptoms, except: [:index]
  default_url_options :host => "example.com"

  devise_for :users, :controllers => {:omniauth_callbacks => 'users/omniauth_callbacks'}
end
