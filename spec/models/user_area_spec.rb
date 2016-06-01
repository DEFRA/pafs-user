# Play nice with Ruby 3 (and rubocop)
# frozen_string_literal: true

require "rails_helper"

RSpec.describe UserArea, type: :model do
  describe "attributes" do
    subject { FactoryGirl.create(:user_area) }

    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :area_id }
    it { is_expected.to_not validate_presence_of :primary }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:area_id) }
  end
end
