require 'mina/rails'
require 'mina/git'
require 'mina/puma'
require 'mina/rbenv'
# for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'ski-back'
set :domain, '39.106.33.76'
set :deploy_to, '/var/www/ski-back'
set :repository, 'git@github.com:luozhonghai/ski-back.git'
set :branch, 'develop'
set :user, 'root'
# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#set :port, '30000'           # SSH port number.
set :forward_agent, true     # SSH forward_agent.

# Shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# Some plugins already add folders to shared_dirs like `mina/rails` add `public/assets`, `vendor/bundle` and many more
# run `mina -d` to see all folders and files already included in `shared_dirs` and `shared_files`
set :shared_dirs, fetch(:shared_dirs, []).push('log','tmp','public/assets')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key')


set :rbenv_path_custom, "$HOME/.rbenv"

task :'rbenv:load_custom' do
  comment %{Loading rbenv}
  command %{export RBENV_ROOT="#{fetch(:rbenv_path_custom)}"}
  command %{export PATH="/usr/pgsql-9.6/bin:$PATH"}
  command %{export PATH="#{fetch(:rbenv_path_custom)}/bin:$PATH"}
  command %{
    if ! which rbenv >/dev/null; then
      echo "! rbenv not found"
      echo "! If rbenv is installed, check your :rbenv_path setting."
      exit 1
    fi
  }
  command %{eval "$(rbenv init -)"}
end

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load_custom'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end


# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0 --skip-existing}
  command %{touch "#{fetch(:shared_path)}/config/database.yml"}
  command %{touch "#{fetch(:shared_path)}/config/master.key"}

  # puma.rb 配置puma必须得文件夹及文件
  command %[mkdir -p "#{fetch(:shared_path)}/tmp/pids"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/tmp/pids"]

  command %[mkdir -p "#{fetch(:shared_path)}/tmp/sockets"]
  command %[chmod g+rx,u+rwx "#{fetch(:shared_path)}/tmp/sockets"]

  command %[touch "#{fetch(:shared_path)}/tmp/sockets/puma.state"]
end


desc "scp local config files to remote shared config folders."
task :scpconfig do
  comment 'scp local config files'
  ssh_port = fetch(:port)
  ssh_host = fetch(:domain)
  ssh_user = fetch(:user)
  shared_path = fetch(:shared_path)

  run :local do
    command "scp -P #{ssh_port} config/database.production.yml #{ssh_user}@#{ssh_host}:#{shared_path}/config/database.yml"
    command "scp -P #{ssh_port} config/master.key #{ssh_user}@#{ssh_host}:#{shared_path}/config/master.key"
    # 按照环境分别命名为development.rb及production.rb.
    command "scp -P #{ssh_port} config/puma/production.rb #{ssh_user}@#{ssh_host}:#{shared_path}/config/puma.rb"
  end
end

task :stop_cron do
  comment 'clear cron task'
  command %[
    if [ -e "#{fetch(:current_path)}" ]; then
      cd #{fetch(:current_path)} && bundle exec whenever -c
      crontab -l
    else
      echo 'No app current path!';
    fi
  ]
end

task :start_cron do
  comment 'start cron task'
  command %[
    if [ -e "#{fetch(:current_path)}" ]; then
      cd #{fetch(:current_path)} && bundle exec whenever -i
      crontab -l
    else
      echo 'No app current path!';
    fi
  ]
end

task :status_cron do
  comment 'show cron tasks'
  command %[crontab -l]
end


desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    command %{#{fetch(:rails)} db:seed}
    #invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
      #invoke :'puma:phased_restart'
      #invoke :'start_cron'
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

task :deploy_first do
  run :local do
    command %[mina setup]
    command %[mina scpconfig]
    command %[mina deploy]
    command %[mina puma:start]
    command %[mina start_cron]
  end
end

task :deploy_maintain do
  run :local do
    command %[mina stop_cron]
    command %[mina deploy]
    command %[mina puma:restart]
    command %[mina start_cron]
  end
end

task :cp_assets do
  run :local do
    command %[mina rake[assets:precompile]]
    command %[mina puma:start]
  end
end


# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
