# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  resources :albums do
    resources :posts do
      member do
        get :status
      end
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Shrine.uppy_s3_multipart(:cache) => '/s3/multipart'
end
