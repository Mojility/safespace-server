# config valid only for current version of Capistrano
lock "3.8.0"

set :rvm_type, :user
set :rvm_ruby_version, '2.2@safespace'

set :application, "safespace-server"
set :repo_url, "git@github.com:Mojility/safespace-server"

set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('config/unicorn', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/uploads')

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :publishing, :restart

end