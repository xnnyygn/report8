require "rvm/capistrano"
require 'bundler/capistrano'

set :user, "vagrant"
set :application, "report8"
set :domain, "report8.xnnyygn.in"
set :rails_env, :production

set :rvm_type, :user
set :rvm_ruby_string, 'ruby-2.1.0'

set :repository,  "https://github.com/xnnyygn/report8.git"
set :scm, :git
set :branch, :master
set :scm_verbose, true

set :deploy_via, :remote_cache
set :use_sudo, false
set :deploy_to, "/home/#{user}/deploy/#{application}"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc 'cause passenger to perform a restart'
  task :restart do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  desc 'reload the database with seed data'
  task :seed do
    run 'cd #{current_path}; rake db:seed RAILS_ENV=#{rails_env}'
  end
end