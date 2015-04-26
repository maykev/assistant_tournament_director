Rails.application.routes.draw do
  devise_for :admins
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  root 'match#index'

  resources :match, only: [:create, :index, :update]
  resources :player, only: [:index]

  namespace :admin do
    post 'match/create' => 'match#create'
    resources :match, only: [:update]
  end
end
