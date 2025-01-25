Rails.application.routes.draw do
  devise_for :administrators

  # Rota para a listagem de administradores
  resources :administrators, only: [:index]

  # Define a rota inicial
  root to: "administrators#index"
end
