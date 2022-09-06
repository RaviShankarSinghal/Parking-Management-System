Rails.application.routes.draw do
  root 'home#index'
  get 'home/login', to:"home#login"
  get 'home/login2'
  get 'home/Employee_page', to: 'home#Employee_page'
  get 'home/Employee_page2'
  get 'admin_page/search'
  get 'admin_page/search1'
  get '/delete_user', to: 'home#delete_user', as: :delete
  resources :admin_page do
    get '/delete', to: 'admin_page#delete'
  end
  resources :employee do
    get '/delete', to: 'employee#delete'
    get '/show1', to: 'employee#show1'
  end
end
