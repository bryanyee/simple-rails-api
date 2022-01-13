Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :users
  resources :greetings, only: [:index, :show, :create]

  get 'greetings/hello'
  get 'greetings/world', to: 'greetings#world'
end
