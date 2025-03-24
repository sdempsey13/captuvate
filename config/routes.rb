Rails.application.routes.draw do
  root "home#index"
  
  devise_for :users

  resources :domains

  get "snap_shots/:id", to: "snap_shots#show", as: :snap_shots

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
