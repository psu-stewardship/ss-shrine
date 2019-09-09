# frozen_string_literal: true

Rails.application.routes.draw do
  resources :posts do
    member do
      get :status
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
