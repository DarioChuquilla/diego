


require 'bundler/capistrano'
set :application, "motels"
load "lib/deployer/deployer.rb"
global_defaults 

set :repository,  "git@github.com:DarioChuquilla/diego.git"
set :scm, :git
set :user, "dchuquilla"  # The server's user for deploys
ssh_options[:forward_agent] = true
set :branch, "master"
set :git_enable_submodules, 1

# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts


task :preview do
  # set :repository,  "https://svn.nettheory.com/mws-2011/trunk"  
  # set :files_repository,  "https://svn.nettheory.com/mws-2011/files"  
  set :rails_env, "preview"
  set :ruby_path, "/usr/local/bin"
  server "54.187.116.151", :app, :web, :db, :primary => true
  defaults
  set :deploy_via, :remote_cache  
  set :apache_user, "www-data"
  set :apache_group, "dev"
  set :apache_dir, "/etc/apache2/conf.d"
  set :apache_logs, "/var/log/apache2/#{application}-#{rails_env}"
end

task :production do
  # set :repository,  "https://svn.nettheory.com/mws-2011/trunk"  
  # set :files_repository,  "https://svn.nettheory.com/mws-2011/files"  
  set :rails_env, "production"
  set :ruby_path, "/usr/local/bin"
  server "54.187.116.151", :app, :web, :db, :primary => true
  defaults
  set :deploy_via, :remote_cache  
  set :apache_user, "www-data"
  set :apache_group, "dev"
  set :apache_dir, "/etc/apache2/conf.d"
  set :apache_logs, "/var/log/apache2/#{application}-#{rails_env}"
end

namespace :deploy do
  task :start do ; end
  task :stop do ; end
end
