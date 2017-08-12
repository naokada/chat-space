Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resources :users, only: [:edit, :update]
  resources :groups, only: [:index, :show, :new, :create, :edit, :update] do
    resources :messages, only: [:index]
  end
end
