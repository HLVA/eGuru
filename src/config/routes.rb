Rails.application.routes.draw do

  resources :questions
  get 'about_us' => 'general#aboutus'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :experiences

  resources :friendships
  post 'accept_friend' => 'friendships#accept_friend'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end
  get '/users/:id', to: 'users#show'
  get 'show_user' => 'users#show'
resources :conversations do
  resources :messages
 end
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    mount ActionCable.server => '/cable'

  root "temp#index"

  # For fb login
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
