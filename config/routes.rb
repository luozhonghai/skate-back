Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, :path => ""  do
    get 'single/update_user'
    get 'single/get_user'
    get 'single/toplist'

    get 'online/update_user'
    get 'online/get_user'
    get 'online/toplist'


  end
end
