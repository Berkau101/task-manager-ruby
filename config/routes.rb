Rails.application.routes.draw do
  root "tasks#index"
  resources :users, only: %i[index new create destroy]
  resources :tasks
end
