Rails.application.routes.draw do
  root                 "static_pages#home"

  get     "help"    => "static_pages#help"
  get     "about"   => "static_pages#about"
  get     "contact" => "static_pages#contact"
  get     "signup"  => "users#new"
  get     "login"   => "sessions#new"
  post    "login"   => "sessions#create"
  delete  "logout"  => "sessions#destroy"

  get "/users/:user_id/events/:id/invite", to: "events#invite", as: "invite"

  get "users/:id/dashboard", to: "users#dashboard", as: "dashboard"
  get "users/:id/change_passwrod", to: "users#change_password", as: "change_password"
  
  resources :users do
    resources :events
    resources :account_activations, only: [:new, :create]
  end

  resources :events do
    resources :guests
  end

  resources :account_activations, only: :edit
end
