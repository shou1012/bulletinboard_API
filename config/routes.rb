Rails.application.routes.draw do
  devise_for :users, only: []
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :v1, defaults: { format: :json } do
    resource :login, only: [:create], controller: :sessions
    resources :users, only: [:create, :update, :destroy, :show]
    resources :rooms, only: [:index, :show, :create, :update, :destroy] do
      resources :comments, module: :rooms
    end
  end

end
