Rails.application.routes.draw do
  root to: 'users#index'
  resources :users , only: %i[new create show] 
  resources :events, only: %i[new create show index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'sign_up' => 'users#new'
  get 'sign_in'  => 'sessions#new'
  delete 'sign_out' => 'sessions#destroy'
  post 'sign_in' => 'sessions#create'
end
