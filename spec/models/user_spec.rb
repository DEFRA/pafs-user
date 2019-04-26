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
    subject { FactoryBot.build(:user) }
    it "returns :first_name and :last_name" do
      expect(subject.full_name).to eq("#{subject.first_name} #{subject.last_name}")
    end
  end
end
