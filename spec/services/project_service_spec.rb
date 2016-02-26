require 'rails_helper'

RSpec.describe ProjectService do
  describe ".generate_reference_number" do
    let(:reference_number) { ProjectService.generate_reference_number }
    it "returns a 7 character string starting with the letter P" do
      expect(reference_number.length).to eq(7)
      expect(reference_number.start_with?('P')).to be true
    end
  end
end

