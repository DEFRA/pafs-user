require 'rails_helper'

RSpec.describe Project, :type => :model do
  describe "attributes" do
    subject { FactoryGirl.create(:project) }

    it { is_expected.to validate_presence_of :reference_number }

    it { is_expected.to validate_uniqueness_of :reference_number }

    it "uses :reference_number as a URL slug" do
      expect(subject.to_param).to eq(subject.reference_number)
    end
  end
end

