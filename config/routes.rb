# frozen_string_literal: true
require 'sidekiq/web'


Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  resources :posts do
    member do
      get :status
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Shrine.presign_endpoint(:cache) => "/s3/params"
  
end
