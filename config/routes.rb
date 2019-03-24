Rails.application.routes.draw do
  resources :games, except: [:edit, :update, :delete]
  get '/games/:id/play', to: 'games#edit', as: 'game_play'
  patch '/games/:id/play', to: 'games#update', as: 'update_game_play'

  root :to => "static#index"
end
