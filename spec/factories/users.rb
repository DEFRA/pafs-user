# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    first_name "Ray"
    last_name "Clemence"
    email "ray@example.com"
    password "Secr3tP@ssw0rd"
  end
end
