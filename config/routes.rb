Rails.application.routes.draw do

  resources :invites

  devise_for :administrators

  root to: "administrators#index"

  resources :administrators, only: [:index, :edit, :update, :destroy] do
    get 'relate_invites', on: :member
    post 'associate_invites', on: :member
    get :invites
  end

  resources :administrator_company_invites, only: [:destroy]

  resources :companies do
    member do
      get :relate_invites
      post :associate_invites
    end
  end

end
