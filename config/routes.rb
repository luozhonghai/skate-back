Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, :path => ""  do
    get 'single/update_user'
    get 'single/get_user'
    get 'single/toplist'

    get 'online/update_user'
    get 'online/get_user'
    get 'online/toplist'

    get 'challenge/send_request'
    get 'challenge/receive_request'
    get 'challenge/send_result'
    get 'challenge/receive_result'
    get 'challenge/win'
    get 'challenge/get_user'
    get 'challenge/toplist'

  end
end
