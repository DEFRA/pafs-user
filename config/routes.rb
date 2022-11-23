# frozen_string_literal: true

Rails.application.routes.draw do
  # use our own passwords controller
  devise_for :users, controllers: { passwords: "passwords" }

  resources :account_requests, only: %i[show new create]

  # We use high voltage to manage static content incl home page
  # See -- config/initializers/high_voltage.rb
  # for the home/root page
  #  get "/pages/*id" => 'high_voltage/pages#show', as: :page, format: false
  get "/password/reset" => "reset_password#reset", as: :after_password_reset

  mount PafsCore::Engine, at: "/pc"

  resource :cookies, only: %i[edit update] do
    member do
      post :accept_analytics
      post :reject_analytics
      post :hide_this_message
    end
  end

  get "/cookies", to: "pafs_core/pages#cookies"

  match "(errors)/:status", to: PafsCore::Engine, via: :all, constraints: { status: /\d{3}/ }

  root to: "pafs_core/projects#index"

end
