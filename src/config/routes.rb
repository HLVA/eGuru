Rails.application.routes.draw do

  resources :photos
  resources :categories
  resources :questions
  get 'about_us' => 'general#aboutus'
  get 'send_mail' => 'general#send_mail'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :experiences

  resources :friendships
  post 'accept_friend' => 'friendships#accept_friend'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [ :create, :edit, :update]
  end
  get '/users/:id', to: 'users#show'
  get 'show_user' => 'users#show'
  get 'edit_user' => 'user#edit'
  get 'user_profile' => 'users#profile'
resources :conversations do
  resources :messages
 end
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get "after_login" => "friendships#after_login"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    mount ActionCable.server => '/cable'

  root "experiences#index"

  # For fb login
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

end
