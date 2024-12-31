# frozen_string_literal: true

Rails.root.glob("spec/support/features/**/*.rb").each { |f| require f }

RSpec.configure do |config|
  config.before(:suite) do
    PafsCore::ReferenceCounter.seed_counters
  end

  config.include Features::AuthenticationSteps, type: :feature
  config.include Features::ProposalSteps, type: :feature
end
