Rails.application.routes.draw do
  resources :users , only: %i[new create show] 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get 'sign_in'  => 'sessions#new'
  delete 'sign_out' => 'sessions#destroy'
  post '/sign_in' => 'sessions#create'
end
