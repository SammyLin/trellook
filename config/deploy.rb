namespace :deploy do
 desc 'Symlink shared directories and files'
 task :symlink_directories_and_files do
 run "ln -s #{shared_path}/config/application.yml #{release_path}/config/application.yml"
 end
end