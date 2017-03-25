server 'safespace.commonsroot.com', user: 'safespace', roles: %w{web app db}
set :rails_env, :production

set :branch, :master
set :deploy_to, "/app/safespace/#{fetch(:application)}"