Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :pets do
    resources :adoptions do # criando a rota>> /pets/:id/adoptions 
      # collection do
      #   get 'adoptions_pet'
      # end
    end

    member do
      get 'adoptions_pet'
    end

    collection do
      get 'owner'
    end
  end
  
  
  
end
