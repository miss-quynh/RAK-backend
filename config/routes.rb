Rails.application.routes.draw do

  get '/organizations/search' => 'organizations#search'

  post '/organization_token' => 'organization_token#create'
  post '/donor_token' => 'donor_token#create'

  get '/filters', to: 'donors#filter_options'
  post '/filters', to: 'donors#filter'

  resources :organizations
  post '/organizations/ein', to: 'organizations#ein'

  resources :projects do
    resources :events, only: [:show, :update]
  end

  resources :donors, except: [:index]

  resources :donations, only: [:show, :create, :update, :destroy]

end
