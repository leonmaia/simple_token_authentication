Rails.application.routes.draw do
  resources :users

  #Authentication routes
  post '/auth/login' => 'auth#login'
  delete '/auth/logout' => 'auth#logout'
end
