Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    devise_for :admins
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

    root 'match#index'

    resources :tournaments, only: [:index, :show]
    get 'tournaments/:id/players' => 'tournaments#players'

    resources :match, only: [:create, :index, :update]
    resources :player, only: [:index]

    namespace :api do
        resources :players, only: [:index]
        resources :matches, only: [:index, :create, :update]
        resources :tournaments, only: [:index, :show]
        get 'tournaments/:id/tables' => 'tournaments#tables'
    end

    namespace :admin do
        resources :match, only: [:update]
        resources :tournament, only: [:update]
    end
end
