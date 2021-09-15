Rails.application.routes.draw do

  resources :posts

  get 'blogs/index'
  
  resources :blogs

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'hello/index' => 'hello#index'
  root 'hello#index'
end
