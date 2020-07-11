require 'rails_helper'

RSpec.describe HomeHelper, type: :helper do
  describe '#round_number_to_closest' do
    it 'works, and rounds down' do
      expect(round_number_to_closest(1234, 50)).to eq(1200)
      expect(round_number_to_closest(666, 100)).to eq(600)
    end

    it 'ignores numbers below the group size' do
      expect(round_number_to_closest(32, 50)).to eq(32)
      expect(round_number_to_closest(66, 100)).to eq(66)
    end
  end

end
