require 'sidekiq/web'

Rails.application.routes.draw do
  get 'comments/create'
  resources :projects do
    resources :comments, module: :projects #nests comments within projects and sets
    # scope for controllers/projects/comments_controller.rb
  end
  root to: 'projects#index'
  
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
