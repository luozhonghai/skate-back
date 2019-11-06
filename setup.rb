def move_webpacker_javascript_directory_to_root
  run "mv app/javascript frontend"
end

#web pack install
"bundle exec rails webpacker:install"

#move_webpacker_javascript_directory_to_root

"mv app/javascript frontend"

#install_ujs
"yarn add @rails/ujs@6.0.0-beta2"

#install_turbolinks
"yarn add turbolinks@5.2.0"

#setup_tailwindcss
"yarn add tailwindcss"
"mkdir -p frontend/stylesheets"
"mkdir -p frontend/images"

#setup_postcss_plugins
"yarn add @fullhuman/postcss-purgecss"
"yarn add postcss-nested@4.1.2"

#setup_stimulus
"bundle exec rails webpacker:install:stimulus"