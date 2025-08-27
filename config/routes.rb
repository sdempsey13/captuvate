Rails.application.routes.draw do
  root "home#index"
  
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resource :dashboard, only: [:show], controller: 'dashboard'
  resources :campaigns, only: [:index, :show], path: 'tests'

  namespace :settings do
    resources :api_keys, controller: "integration_credentials", only: [:index, :create, :destroy]
  end

  post "/vwo/webhooks", to: "vwo_webhooks#receive"
  
  resources :domains
  get "domains/:id/desktop", to: "domains#show_desktop", as: :domain_desktop
  get "domains/:id/mobile", to: "domains#show_mobile", as: :domain_mobile

  get "snap_shots/:id", to: "snap_shots#show", as: :snap_shots
  post "snap_shots/create/:id", to: "snap_shots#create", as: :take_snap_shot

  post "domain_schedules/set_activation/:id", to: "domain_schedules#set_activation", as: :set_domain_schedule_activation

  post "comments", to: "comments#create"

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admin do
    resource :domain_uploader, only: [:new, :create], controller: 'domain_uploader'
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
