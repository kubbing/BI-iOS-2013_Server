set :application, 'BI-iOS-2013_Server'
set :repo_url, 'git@github.com:kubbing/BI-iOS-2013_Server.git'


# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/www/BI-iOS-2013_Server'
set :scm, :git

set :format, :pretty
set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{tmp/pids tmp/cache public/uploads}

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
  
  # namespace :symlink do
  #   desc 'Symlink uploads'
  #   task :uploads do
  #     on roles(:app) do |host|
  #       execute "mkdir -p #{shared_path}/public/uploads"
  #       execute "ln -nfs #{shared_path}/public/uploads #{release_path}/public/uploads"
  #       execute "ln -nfs #{shared_path}/certificates #{release_path}/certificates"
  #     end
  #   end
  # 
  #   after :shared, 'deploy:symlink:uploads'
  # end
  
  namespace :push do
    set :pushd_pid_file, "#{current_path}/tmp/pids/push_daemon.pid"
  
    desc 'Start the push daemon'
    task :start do
      on roles(:app) do
        execute "cd #{current_path}; nohup bundle exec push #{fetch(:stage)} -p #{fetch(:pushd_pid_file)} >> #{current_path}/log/push.log 2>&1 &", :pty => false
      end
    end
  
    desc 'Stop the push daemon'
    task :stop do
      on roles(:app) do
      execute "if [ -d #{current_path} ] && [ -f #{fetch(:pushd_pid_file)} ] && kill -0 `cat #{fetch(:pushd_pid_file)}`> /dev/null 2>&1; then kill -KILL `cat #{fetch(:pushd_pid_file)}` ; else echo 'push daemon is not running'; fi"
      end
    end
  
    desc "Restart the push daemon"
    task :restart do
      on roles:(:app) do
        stop
        start
      end
    end
  
    after :stop, 'deploy:push:stop'
    after :start, 'deploy:push:start'
    before :restart, 'deploy:push:restart'  
  end
  
  
  
end

