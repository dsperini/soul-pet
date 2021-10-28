Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :pets do
    resources :adoptions # criando a rota>> /pets/:id/adoptions

    # member do
    #   # /restaurants/:id/chef
    #   get 'owner'
    # end

    collection do
      get 'owner'
    end
  end
  
  
  
end
