Rails.application.routes.draw do
    devise_for :admins
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

    root 'match#index'

    resources :tournaments, only: [:show]
    get 'tournaments/:id/players' => 'tournaments#players', as: 'tournament_players'

    resources :match, only: [:create, :index, :update]
    resources :player, only: [:index]

    namespace :api do
        resources :players, only: [:index]
        resources :matches, only: [:index, :create, :update]
        resources :tournaments, only: [:index, :show]
        get 'tournaments/:id/tables' => 'tournaments#tables'
    end

    namespace :admin do
        post 'tournament/create' => 'tournament#create'
        post 'match/create' => 'match#create'
        resources :match, only: [:update]
    end
end
