Rails.application.routes.draw do
  root 'home#index'
  get 'home/login', to:"home#login"
  get 'home/login2'
  resources :admin_page do
    get '/delete', to: 'admin_page#delete'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
