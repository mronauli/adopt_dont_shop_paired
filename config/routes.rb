Rails.application.routes.draw do
  get '/', to:  'startup#index'

  resources :shelters do
    resources :pets, only: [:index, :new, :create, :update]
  end

  resources :pets, except: [:new, :create]

  get '/shelters/:id/reviews/new', to: 'reviews#new'
  post '/shelters/:id/reviews', to: 'reviews#create'
  get '/shelters/:id/reviews/:id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:id', to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:id', to: 'reviews#destroy'

  get '/favorites', to: 'favorites#index'
  delete '/favorites', to: 'favorites#destroy_all'
  patch '/favorites/:id', to: 'favorites#update'
  delete '/favorites/:id', to: 'favorites#destroy'

  get '/applications/new', to: 'applications#new'
  get '/applications/:id', to: 'applications#show'
  post '/applications', to: 'applications#create'

  get '/pet_applications/:id', to: 'pet_applications#index'
  patch '/applications/:application_id/pet_applications/:pet_id/approved', to: 'pet_applications#approved'
  patch '/applications/:application_id/pet_applications/:pet_id/revoked', to: 'pet_applications#revoked'
end
