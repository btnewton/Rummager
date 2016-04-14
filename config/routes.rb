Rails.application.routes.draw do
  devise_for :users
  get 'users/new'

  resources :twitter_accounts do
    resources :tweets
  end

  authenticated :user do
    root 'twitter_accounts#index', as: :authenticated_root
  end

  root 'welcome#index'

end
