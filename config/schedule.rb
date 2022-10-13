# frozen_string_literal: true

# rubocop:disable Layout/LineLength
job_type :rake, "cd :path && . ../../.exportedenv && :environment_variable=:environment bundle exec rake :task --silent :output"
# rubocop:enable Layout/LineLength

# Disabling this for now as it has not been running for a long time
# every 1.day, at: "1:00 am" do
#  rake "users:clean"
# end
