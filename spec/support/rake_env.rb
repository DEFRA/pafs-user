# frozen_string_literal: true

# Adapted from: https://thoughtbot.com/blog/test-rake-tasks-like-a-boss
# and https://stackoverflow.com/a/42172531
#
# Used to resolve an issue with simplecov test reporting of rake tasks. It first
# arose when we implemented integration tests for a rake tast for the first
# time. That spec was actually testing 2 tasks in the same task namespace. The
# problem was whichever was run last would overwrite the coverage data
# for the other.
#
# According to https://stackoverflow.com/a/42172531 the belief is
#
#   SimpleCov uses `Coverage#result` module from Ruby standard library to check
#   what was covered. `Coverage#result` gets reset for the file [..] when you
#   re-load the file using Kernel load.
#
# So everytime we were invoking a task in one test, it would overwite the
# results captured in the previous.
#
# We thought we nailed it by placing the calls below in a `before(:all)` block
# in `spec/shared_examples/rake.rb`, but then found this caused all our rake
# tasks to be flagged as missing coverage. Next step was to add some basic
# unit tests which if run in isolation gave a 100% test coverage. But when the
# full suite was run the same behaviour happened again. Now the last rake spec
# to be run would blitz the test coverage for the others.
#
# So following the logic in the stackoverflow article to its conclusion, we
# moved the calls here to ensure they happen before any rake tasks are run.
# Doing so has resolved the problem with our test coverage, and now it is
# retaiuned for each rake spec irrespective if one or all are run.
#
# See also spec/shared_examples/rake.rb
RSpec.configure do |config|
  config.before(:suite) do
    Rake.application = Rake::Application.new
    Rails.application.load_tasks

    Rake::Task.define_task(:environment)
  end

  config.before(:each, type: :rake) do
    DatabaseCleaner.strategy = :deletion
  end

  config.after(type: :rake) do
    DatabaseCleaner.clean_with(:deletion)
  end
end
