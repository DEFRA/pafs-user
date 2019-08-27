job_type :rake, "cd :path && . ../../.exportedenv && :environment_variable=:environment bundle exec rake :task --silent :output"

# Disabling this for now as it has not been running for a long time
#every 1.day, at: "1:00 am" do
#  rake "users:clean"
#end
