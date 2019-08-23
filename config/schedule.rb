job_type :rake, "cd :path && . ../../.exportedenv && :environment_variable=:environment bundle exec rake :task --silent :output"

every 1.day, at: "1:00 am" do
  rake "users:clean"
end
