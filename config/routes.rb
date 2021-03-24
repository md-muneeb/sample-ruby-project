Rails.application.routes.draw do
  resources :items, only: [:index, :new, :destroy, :edit, :create, :update]
  resources :fish, only: [:index, :new, :destroy, :edit, :create, :update]
end
