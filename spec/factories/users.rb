# frozen_string_literal: true

FactoryBot.define do
  factory :account_user, class: User do
    first_name { "Ray" }
    last_name { "Clemence" }
    email { "ray@example.com" }
    password { "Secr3tP@ssw0rd" }

    trait :invited do
      transient do
        raw_invitation_token { SecureRandom.hex(16) }
      end

      invitation_created_at { 1.hour.ago }
      invitation_token { Devise.token_generator.digest(User, :invitation_token, raw_invitation_token) }
      invitation_sent_at { 1.hour.ago }
    end

    trait :ea do
      after(:create) do |user|
        area = PafsCore::Area.ea_areas.first || create(:ea_area)
        user.user_areas.create(area: area, primary: true)
      end
    end

    trait :pso do
      after(:create) do |user|
        area = PafsCore::Area.pso_areas.first || create(:pso_area)
        user.user_areas.create(area: area, primary: true)
      end
    end

    trait :rma do
      after(:create) do |user|
        area = PafsCore::Area.rma_areas.first || create(:rma_area)
        user.user_areas.create(area: area, primary: true)
      end
    end
  end
end
