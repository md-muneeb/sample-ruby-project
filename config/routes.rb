Rails.application.routes.draw do
  resources :items, only: [:index, :new, :destroy, :edit, :create, :update, :show]
  resources :fish, only: [:index, :new, :destroy, :edit, :create, :update, :show]
end
