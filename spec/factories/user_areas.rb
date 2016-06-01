# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
FactoryGirl.define do
  factory :user_area do
    user_id 1
    area_id 1
    primary true
  end
end
