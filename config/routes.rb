Rails.application.routes.draw do
  resources :properties, except: [:new, :edit], defaults: { format: :json } do
    scope module: :properties do
      resources :leases
      resources :invoices
    end
  end

  resource :dashboard, only: :show
  resource :me, only: :show, controller: "me", defaults: { format: :json }

  devise_for :users, controllers: { 
    sessions: "users/sessions",
    registrations: "users/registrations",
  }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'dashboards#show'
end
