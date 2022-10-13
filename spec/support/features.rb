# frozen_string_literal: true

Dir[Rails.root.join("spec/support/features/**/*.rb")].sort.each { |f| require f }

RSpec.configure do |config|
  config.before(:suite) do
    PafsCore::ReferenceCounter.seed_counters
  end

  config.include Features::AuthenticationSteps, type: :feature
  config.include Features::ProposalSteps, type: :feature
end
