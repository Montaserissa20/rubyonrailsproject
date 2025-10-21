Rails.application.routes.draw do
  # Optional: simple JSON root so "/" doesn't 404
 root "home#index"


  namespace :api do
    namespace :v1 do
      resources :users,    only: [:index, :show, :create, :update, :destroy]
      resources :articles do
        resources :comments, only: [:index, :create]
      end
      resources :comments, only: [:show, :update, :destroy]
      resources :tags,     only: [:index, :show, :create, :update, :destroy]
      post   "articles/:id/tags/:tag_id", to: "articles#attach_tag"
      delete "articles/:id/tags/:tag_id", to: "articles#detach_tag"
      post   "login", to: "auth#login"
    end
  end
end
