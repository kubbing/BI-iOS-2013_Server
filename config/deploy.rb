set :application, 'BI-iOS-2013_Server'
set :repo_url, 'git@github.com:kubbing/BI-iOS-2013_Server.git'


# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/www/BI-iOS-2013_Server'
set :scm, :git

set :format, :pretty
set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'
  
  namespace :symlink do
  
    desc 'Symlink uploads'
    task :uploads do
      on roles(:app) do |host|
        execute "mkdir -p #{shared_path}/public/uploads"
        execute "ln -nfs #{shared_path}/public/uploads #{release_path}/public/uploads"
        execute "ln -nfs #{shared_path}/certificates #{release_path}/certificates"
      end
    end
  
    after :shared, 'deploy:symlink:uploads'
    
  end
  
end

