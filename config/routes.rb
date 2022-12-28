Rails.application.routes.draw do
  root 'matches#index'
  get 'results/index'
  resource :password_reset, only: %i[new create edit update]
  get 'matches/update_ru'
  get 'matches/update_eu'
  post 'matches/favorite_matches', as: 'matches'
  resource :teams, only: %i[new create show update]
  get 'teams/index'
  post 'teams/close'
  resources :users do
    member do
      get :confirm_email
    end
  end
  resource :session, only: %i[new create destroy]
end
