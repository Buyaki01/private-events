Rails.application.routes.draw do
  root to: 'events#index'
  resources :users , only: %i[new create show] 
  resources :events, only: %i[new create show index]
  get 'sign_up' => 'users#new'
  get 'sign_in'  => 'sessions#new'
  delete 'sign_out' => 'sessions#destroy'
  post 'sign_in' => 'sessions#create'
  get 'attend_events', to: 'events#show_events'
  post 'attend_events', to: 'events#attend_events'
end
