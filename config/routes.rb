Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, :path => ""  do
    post 'single/update_user'
    post 'single/get_user'
    post 'single/toplist'

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
