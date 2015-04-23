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
  
  resources :users do
    resources :events do
    end
  end

  resources :events do
    resources :guests
  end
end
