Rails.application.routes.draw do

  post '/organization_token' => 'organization_token#create'
  post '/donor_token' => 'donor_token#create'

  resources :organizations

	resources :projects do
		resources :events, only: [:show, :update]
	end

  resources :donors, except: [:index]

  resources :donations, only: [:show, :create, :update]

  get '/filters', to: 'donors#filter_options'
  post '/filters', to: 'donors#filter'

  root to: 'donors#index'
end
