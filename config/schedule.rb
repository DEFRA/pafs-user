every 1.day, at: "1:00 am", roles: [:cleaner] do
  rake "users:clean"
end
