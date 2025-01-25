Rails.application.routes.draw do
  resources :companies
  devise_for :administrators

  # Rota para a listagem de administradores
  resources :administrators, only: [:index, :edit, :update, :destroy]

  # Define a rota inicial
  root to: "administrators#index"
end
