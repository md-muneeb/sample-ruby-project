Rails.application.routes.draw do
  resources :items, only: [:index, :show, :new, :destroy, :edit, :create, :update]
  resources :fishes, only: [:index, :show]
end
