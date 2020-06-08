Rails.application.routes.draw do

  resources :users
  namespace :api, :path => "" do
    post 'manage/auth'
    post 'manage/shot'
    post 'manage/server_url'
  end
  authenticated :account do
    root to: 'dashboard#show', as: :authenticated_root
  end

  devise_for :accounts, path: "/", path_names: { sign_up: "signup", sign_in: "login", sign_out: "logout", edit: "edit" }, controllers: { masquerades: "admin/masquerades" }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, :path => ""  do
    post 'single/update_user'
    post 'single/get_user'
    post 'single/toplist'
    post 'single/is_user_unique'
    post 'single/get_score_rank'

    post 'online/update_user'
    post 'online/get_user'
    post 'online/toplist'

    post 'challenge/send_request'
    post 'challenge/receive_request'
    post 'challenge/send_result'
    post 'challenge/receive_result'
    post 'challenge/win'
    post 'challenge/get_user'
    post 'challenge/toplist'

    post 'single_map/is_user_unique'
    post 'single_map/get_score_rank'
    post 'single_map/update_user'
    post 'single_map/get_user'
    post 'single_map/toplist'

  end

  root to: 'dashboard#show'
  get 'dashboard/search'
  get 'dashboard/rank'
  post 'dashboard/search_result'

end
