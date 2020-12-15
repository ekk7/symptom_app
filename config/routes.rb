Rails.application.routes.draw do
  root to: 'pages#home'
  resources :symptoms, except: [:index]
end
