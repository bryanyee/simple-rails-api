Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :users do
    resources :posts, only: %i(index create)
  end
  resources :posts, only: %i(show update destroy)

  resources :greetings, only: %i(index show create)

  get 'greetings/hello'
  get 'greetings/world', to: 'greetings#world'
end
