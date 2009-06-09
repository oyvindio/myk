#scp -P 30000 config/database.yml capistrano@innocrowd.com:/var/www/reklame/shared/config

require 'yaml'
require 'net/sftp'

default_run_options[:pty] = true

set :application, "myk"
set :domain, "173.45.236.205"
set :deploy_to, "/var/www/#{application}"
set :runner, "capistrano"
set :user, "capistrano"
set :use_sudo, true
set :port, 30000

set :repository, "git@github.com:christph/myk.git"
set :scm, :git
set :scm_passphrase, "github"
set :scm_verbose, true
set :ssh_options, { :forward_agent => true }
set :branch , "master"
set :deploy_via, :remote_cache
set :git_enable_submodules, 1
# set :git_shallow_clone, 1

#role :app, "DOMAIN"
#role :web, "DOMAIN"
#role :db,  "DOMAIN", :primary => true
#role :app_admin, domain
role :app, domain
role :web, domain
role :db, domain , :primary => true


namespace :deploy do
  after  "deploy:update_code", "deploy:copy_production_configuration"
  after "deploy:copy_production_configuration", "deploy:create_symlinks"
  #before "deploy:migrate",     "deploy:create_production_database"
   after  "deploy:start",     "deploy:restart"
  #after  "deploy:restart",     "deploy:daemon_restart"
  

desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  
  #desc "Fixing the spin"
  #task :fix_script_perms do
  #  run "chmod 755 #{latest_release}/script/spin"
  #end

  
  configurations = {
     "database.yml"   => " #{shared_path}/config/database.yml",
     "config.yml"   => " #{shared_path}/config/config.yml",
     
#    "facebooker.yml" => " #{shared_path}/config/facebooker.yml",
#    "memcached.yml"  => " #{shared_path}/config/memcached.yml"
  }

  desc "Copy production configuration files stored on the same remote server"
  task :copy_production_configuration do
    configurations.each_pair do |file, src|
      run "cp #{src} #{release_path}/config/#{file}"
    end
  end

  desc "Doing paperclip deploy percistante"
  task :create_symlinks do
     run "ln -nfs #{shared_path}/files #{release_path}/public/files"
     run "ln -nfs #{shared_path}/logos #{release_path}/public/logos"
    run "ln -nfs #{shared_path}/photos #{release_path}/public/photos"
    run "ln -nfs #{shared_path}/blog #{release_path}/public"
  end

  desc "Create the production database on the remote server if it doesn't already exist"
  task :create_production_database do
    Net::SFTP.start('DEPLOY_HOST', 'DEPLOY_USER') do |sftp|
      database_yml = YAML::load(sftp.file.open("#{release_path}/config/database.yml", "r"))
      production_database = database_yml["production"]["database"]
     run "mysqladmin create #{production_database} --default-character-set=utf8" rescue Capistrano::CommandError
    end
  end
  
 # desc "symlink vendor/plugins"
 # task :symlink_vendor_plugins do
 #   run "rm -rf #{release_path}/vendor/plugins"
 #   run "ln -fs #{shared_path}/plugins #{release_path}/vendor/plugins"
 # end

  desc "Restarts your application."
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "Install gems."
  task :install_gems, :roles => :app_admin do
    run "#{current_path} rake gems:install"
  end
  
  desc "See the last 100 lines of the production log"
  task :error_log, :roles => :app do
    run "tail -n100 #{shared_path}/log/production.log"
  end
  
  desc "Pseenger status"
  task :passenger_status, :roles => :app do
    run "passenger-status"
  end

  desc "Passenger memory stats"
  task :passenger_memory_stats, :roles => :app do
    run "passenger-memory-stats"
  end
    
  
  #desc "Restart daemon"
  #task :daemon_restart, :roles => :app do
    
   # run "cd #{current_path} && ./script/daemons stop" 
    #run "cd #{current_path} && RAILS_ENV=production lib/daemons/mailer_ctl start"
    #rescue Capistrano::CommandError

 # end


#  namespace :web do
#    desc "Serve up a custom maintenance page."
#    task :disable, :roles => :web do
#      require 'erb'
#      on_rollback { run "rm #{shared_path}/system/maintenance.html" }
#      reason = ENV['REASON']
#      deadline = ENV['UNTIL']
#      template = File.read("app/views/admin/maintenance.html.erb")
#      page = ERB.new(template).result(binding)
#      put page, "#{shared_path}/system/maintenance.html", :mode => 0644
#    end
#  end
end
