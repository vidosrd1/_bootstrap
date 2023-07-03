Rails.application.routes.draw do
  resources :tags
  resources :novines
  resources :arts
  resources :lists
  resources :categories
  resources :blogs
  root "blog_posts#index"
  devise_for :users
  resources :blog_posts
  # root "articles#index"
end
