Rails.application.routes.draw do
  root "tasks#index"
  resources :users, only: %i[index new create]
  resources :tasks
end
