Rails.application.routes.draw do
  root 'home#index'
  get 'home/login', to:"home#login"
  get 'home/login2'
  get 'home/Employee_page', to: 'home#Employee_page'
  get 'home/Employee_page2'
  resources :admin_page do
    get '/delete', to: 'admin_page#delete'
  end
  resources :employee do
    get '/delete', to: 'employee#delete'
  end
end
