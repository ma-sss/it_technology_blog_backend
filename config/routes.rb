Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'Admin', at: 'admin', controllers: {
        registrations: 'api/v1/admin/registrations',
        sessions: 'api/v1/admin/sessions'
      }
      resources :users, only: [:index]
      namespace :admin do
        resources :posts, only: [:index, :show, :update, :destroy]
        resources :posts, only: [:create], path: "/:admin_id/post"
        resources :comments, only: [:show, :update, :destroy]
        resources :comments, only: [:create], path: "/:admin_id/comment"
        resources :replies, only: [:show, :create, :update, :destroy]
        resources :replies, only: [:create], path: "/:admin_id/comment/:comment_id/reply"

      end
      namespace :user do
        resources :comments, only: [:show, :create, :index, :update, :destroy]
        resources :replies, only: [:index, :show, :update, :destroy]
        resources :replies, only: [:create], path: "/comment/:comment_id/reply"
      end
    end
  end
end