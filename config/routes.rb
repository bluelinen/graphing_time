Rails.application.routes.draw do
  resources :users, only: [:show, :index, :create] do
    member do
      post '/add_friend', to: 'users#add_friend'
      get '/search', to: 'users#search'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
