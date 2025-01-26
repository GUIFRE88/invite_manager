Rails.application.routes.draw do
  resources :invites
  devise_for :administrators

  resources :administrators, only: [:index, :edit, :update, :destroy] do
    get 'relate_invites', on: :member
    post 'associate_invites', on: :member
  end

  root to: "administrators#index"

  resources :companies do
    member do
      get :relate_invites
      post :associate_invites
    end
  end

end
