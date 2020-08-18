Rails.application.routes.draw do
  root to: 'events#index'
  resources :users , only: %i[new create show] 
  resources :events, only: %i[new create show index]
  get 'sign_up' => 'users#new'
  get 'sign_in'  => 'sessions#new'
  delete 'sign_out' => 'sessions#destroy'
  post 'sign_in' => 'sessions#create'
  get 'events_attended', to: 'events#attended_event'
  post 'events_attended', to: 'events#add_attended_event'
end
