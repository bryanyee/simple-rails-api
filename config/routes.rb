Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :users
  # resources :users, only: [:index, :show]

  get 'greetings/hello'
  get 'greetings/world', to: 'greetings#world'
end
