Rails.application.routes.draw do
  devise_for :users
  root "groups#index"
  resources :users, only: [:edit, :update]
  resources :groups, except: :destroy do
    resources :messages, only: [:index, :new, :create]
    collection do
      get  :search
    end
  end
end
