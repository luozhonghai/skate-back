Rails.application.routes.draw do

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

  end

  root to: 'pages#home'

end
