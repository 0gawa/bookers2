Rails.application.routes.draw do
  devise_for :users
  resources :users, only:[:new, :show, :edit, :index, :update]
  resources :books, only:[:new, :create, :index, :show, :edit, :destroy]
  root to: 'homes#top'
  get 'homes/about' => 'homes#about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
