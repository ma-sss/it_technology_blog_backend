Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'Admin', at: 'admin', controllers: {
        registrations: 'api/v1/admin/registrations',
        sessions: 'api/v1/admin/sessions'
      }
      namespace :admin do
        resources :posts, only: [:index, :show]
        resources :posts, path: '/:admin_id/posts', except: [:index]
        resources :comments, path: '/:admin_id/comments'
      end
      namespace :user do
        resources :comments, only: [:create]
        resources :comments, only: [:show, :destroy], path: '/:admin_id/comments'
      end
    end
  end
end