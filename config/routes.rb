# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :webhooks do
    post '/email_inbound', to: 'sendgrid#inbound'
  end

  namespace :sessions do
    post '/logout', action: :destroy
  end

  # resources :mailbox, only: %i[index create destroy],
  #                     param: :email,
  #                     constraints: { :email => /[^\/]+/ } do
  #   member do
  #     get :fetch_emails
  #   end
  # end

  namespace :mailbox do
    resources :emails, only: %i[index destroy show], param: :email_id
    get '', action: :index
    post '', action: :create, as: :create
    delete '', action: :destroy, as: :destroy
    get '/:email/:token', action: :login, constraints: { email: %r{[^/]+} }, as: :login
  end

  # resources :mailbox, only: %i[index create destroy] do
  #   collection do
  #     get :fetch_emails
  #   end
  # end

  root to: 'mailbox#index'
end
