Rails.application.routes.draw do
  resources :todos
  get 'home/index'
  resources :tags
  resources :novines
  resources :arts
  resources :lists
  resources :categories
  resources :blogs
  #root "blog_posts#index"
  root "home#index"
  devise_for :users
  resources :blog_posts
  # root "articles#index"
  #root "todos#index" # add this line
end
