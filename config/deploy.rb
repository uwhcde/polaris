# Change these

server '45.55.80.58', roles: [:web, :app, :db], primary: true

set :repo_url,        'git@github.com:uwhcde/polaris.git'
set :application,     'polaris'
set :user,            'deploy'
set :puma_threads,    [4, 16]
set :puma_workers,    0
set :keep_releases, 5

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads public/assets}
set :linked_files, fetch(:linked_files, []).push('config/secrets.yml')

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      # unless `git rev-parse HEAD` == `git rev-parse origin/master`
      #   puts "WARNING: HEAD is not the same as origin/master"
      #   puts "Run `git push` to sync changes."
      #   exit
      # end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  # namespace :assets do

  #   Rake::Task['deploy:assets:precompile'].clear_actions

  #   desc 'Precompile assets locally and upload to servers'
  #   task :precompile do
  #     on roles(fetch(:assets_roles)) do
  #       run_locally do
  #         with rails_env: fetch(:rails_env) do
  #           execute 'rake assets:precompile'
  #           execute 'touch assets.zip && rm assets.zip'
  #           execute 'zip -r assets.zip public/assets/'
  #         end
  #       end

  #       within release_path do
  #         with rails_env: fetch(:rails_env) do
  #           # old_manifest_path = "#{shared_path}/public/assets/manifest*"
  #           # execute :rm, old_manifest_path if test "[ -f #{old_manifest_path} ]"
  #           upload!('assets.zip', "#{shared_path}/public/", recursive: true)
  #           execute("rm -rf #{shared_path}/public/assets || true")
  #           execute("cd #{shared_path}/public/; unzip -o assets.zip; cd ;")
  #           execute("mv #{shared_path}/public/public/assets #{shared_path}/public/")

  #           # upload!('./public/assets/', "#{shared_path}/public/", recursive: true)
  #         end
  #       end

  #       run_locally { execute 'rm -rf public/assets' }
  #       run_locally { execute 'rm assets.zip' }
  #     end
  #   end

  # end



  # namespace :assets do
  #   desc 'Run the precompile task locally and rsync with shared'
  #   task :precompile do
  #     run_locally('rm -rf public/assets/*')
  #     run_locally("RAILS_ENV=#{rails_env} rake assets:precompile")
  #     run_locally('touch assets.tgz && rm assets.tgz')
  #     run_locally('tar zcvf assets.tgz public/assets/')
  #     run_locally('mv assets.tgz public/assets/')
  #   end

  #   desc 'Upload precompiled assets'
  #   task :upload_assets do
  #     upload "public/assets/assets.tgz", "#{release_path}/assets.tgz"
  #     run "cd #{release_path}; tar zxvf assets.tgz; rm assets.tgz"
  #   end
  # end

  # before ':update_code', 'assets:precompile'
  # after 'deploy:create_symlink', 'assets:upload_assets'


  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma
