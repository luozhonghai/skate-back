# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers: a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum; this matches the default thread size of Active Record.
#
max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count
workers 2
# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
#
#port        ENV.fetch("PORT") { 3000 }

environment 'production'
app_name = "skate-back"
application_path = "/var/www/#{app_name}"
directory "#{application_path}/current"

pidfile "#{application_path}/shared/tmp/pids/puma.pid"
state_path "#{application_path}/shared/tmp/sockets/puma.state"
stdout_redirect "#{application_path}/shared/log/puma.stdout.log", "#{application_path}/shared/log/puma.stderr.log"
bind "unix://#{application_path}/shared/tmp/sockets/#{app_name}.sock"
activate_control_app "unix://#{application_path}/shared/tmp/sockets/pumactl.sock"

# Specifies the `environment` that Puma will run in.
#
#environment ENV.fetch("RAILS_ENV") { "development" }

# Specifies the `pidfile` that Puma will use.
#pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked web server processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
# workers ENV.fetch("WEB_CONCURRENCY") { 2 }

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory.
#
daemonize true
on_restart do
  puts 'On restart...'
end
preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
