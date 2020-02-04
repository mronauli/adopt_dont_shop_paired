Rails.application.routes.draw do
  get '/', to:  'startup#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :shelters do 
    resources :pets, only: [:new, :index, :create]
  end 

  resources :pets, except: [:new, :create]

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/shelters/:id/reviews/new', to: 'reviews#create'
end
