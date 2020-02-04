Rails.application.routes.draw do
  get '/', to:  'startup#index'

  resources :shelters do
    resources :pets, only: [:new, :index, :create]
  end

  resources :pets, except: [:new, :create]

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/shelters/:id/reviews', to: 'reviews#create'
end
