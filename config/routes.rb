Rails.application.routes.draw do
  resources :imagens
  resources :productos do
    member do
      delete "delete_image/:imagen_id", to: "productos#delete_image", as: :delete_image
    end
  end
  resources :categoria
  resources :autors
  resources :usuarios, only: [:index, :show]
  get "home/index"
  devise_for :users, path: 'cuentas', path_names: {
  sign_in: 'iniciar_sesion',
  sign_out: 'cerrar_sesion',
  sign_up: 'registrarse'
}
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"
end
