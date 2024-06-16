Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  
  get "home/about"=>"homes#about"
  
  get '/books/search_tag', to: 'books#search_tag', as: "search"
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
  	get 'followings' => 'relationships#followings', as: 'followings'
  	get 'followers' => 'relationships#followers', as: 'followers'
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create, :show]
  resources :groups, except: [:destroy] do
    resource :group_users, only: [:create, :destroy]
    post '/send-notice-mail' => 'groups#send_notice_mail', as: "send_notice_mail"
    get '/new_send_mail' => 'groups#new_send_mail', as: "new_send_mail"
    get '/confirm_mail' => 'groups#confirm_mail', as: "confirm_mail"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post '/count_books' => 'users#count_books', as: 'count_books'
end