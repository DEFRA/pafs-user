every :reboot do
  command "cd ~/pafs-user/current && bundle exec passenger start"
end
