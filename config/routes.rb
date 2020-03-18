Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  post 'tokens/login',    to: 'tokens#login'
  get 'tokens/info',      to: 'tokens#info'
  post 'users',           to: 'users#create'
end
