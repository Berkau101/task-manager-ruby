Rails.application.routes.draw do
  devise_for :users
  root "tasks#index"
  resources :users, only: %i[index new create destroy]
  resources :tasks
end
