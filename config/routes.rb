require 'api_constraints'

Rails.application.routes.draw do
  
  mount SabisuRails::Engine => "/sabisu_rails"
  devise_for :users
  # Api definition example: http://api.market_palce_api.dev/users/1 using pow
  namespace :api, defaults: { format: :json }, constraints: {subdomain: 'api'}, path: '/' do 

    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
    	resources :users, :only => [:show, :create, :update, :destroy] do 
    		resources :products, only: [:create, :update, :destroy]
        resources :orders, :only => [:index, :show]
    	end
    	resources :sessions, :only => [:create, :destroy]
    	resources :products, :only => [:show, :index]
               
    end

  end
end
