# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  resources :albums
  mount Sidekiq::Web => '/sidekiq'

  resources :posts do
    member do
      get :status
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Shrine.uppy_s3_multipart(:cache) => '/s3/multipart'
end
