Rails.application.routes.draw do
  resources :articles
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "sessions", only: [:create, :destroy]
  

 resources :users, controller: "users" do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  root "welcome#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
