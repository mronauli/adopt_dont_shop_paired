Rails.application.routes.draw do
  get '/', to:  'startup#index'

  resources :shelters do
    resources :pets, only: [:new, :index, :create]
  end

  resources :pets, except: [:new, :create]

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/shelters/:id/reviews', to: 'reviews#create'
  get '/shelters/:id/reviews/:id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:id', to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:id', to: 'reviews#destroy'

  patch '/favorites/:id', to: 'favorites#update'
  get '/favorites', to: 'favorites#index'
end
