Rails.application.routes.draw do
  resources :tasks do
    member do
      get 'history'
      get 'version'
    end
  end
  
  resources :users do
    member do
      get 'task_summary'
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
