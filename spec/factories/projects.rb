# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
FactoryGirl.define do
  factory :project do
    reference_number { ProjectService.new.generate_reference_number }
    version 0
  end
end
