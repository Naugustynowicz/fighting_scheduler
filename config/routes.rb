Rails.application.routes.draw do
  devise_for :users, path: "",
    path_names: {
      sign_in: "login",
      sign_out: "logout",
      registration: "signup"
    },
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations"
    }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "application#index"

  # define rails paths
  resources :circuits do
    member do
      patch :add_event
      patch :remove_event
      get :list_events
    end
  end
  resources :clubs do
    member do
      patch :add_training
      patch :remove_training
    end
  end
  resources :events do
    member do
      get :subscribe
      get :attendees
      get :generate_tree_bracket
      get :display_tree_bracket
    end
  end
  resources :matches do
    member do
      get :update_match
      patch :determine_winner
    end
  end
  resources :locations
  resources :roles
  resources :sports
  resources :statuses
  resources :teams
  resources :type_events
  resources :users

  # define user interface paths here
  get "ui", action: :index, controller: "application"
  get "ui/sports", action: :index, controller: "application"
  get "ui/events", action: :index, controller: "application"
end
