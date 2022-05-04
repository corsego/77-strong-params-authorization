Rails.application.routes.draw do
  devise_for :users
  get 'dashboard', to: 'static_pages#dashboard'
  root 'static_pages#landing_page'
  resources :users, only: %i[index edit update]
end
