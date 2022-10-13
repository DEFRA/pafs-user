# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe "attributes" do
    subject { FactoryBot.create(:user) }

    it { is_expected.to validate_presence_of :first_name }

    it { is_expected.to validate_presence_of :last_name }
  end

  describe "#full_name" do
    subject(:user_subject) { FactoryBot.build(:user) }

    it "returns :first_name and :last_name" do
      expect(user_subject.full_name).to eq("#{user_subject.first_name} #{user_subject.last_name}")
    end
  end
end
