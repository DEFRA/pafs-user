every :reboot, roles: [:app] do
  command "cd ~/pafs-user/current && bundle exec passenger start"
end
