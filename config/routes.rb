Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'live_scoring#index'

  resources :match, only: [:create, :index, :new]
end
