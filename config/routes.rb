DbcRspecRails::Application.routes.draw do
  namespace :admin do
    resources :posts
    resources :sessions, :only => [:new, :create, :destroy]
  end

  resources :posts

  root :to => "home#index"
end
