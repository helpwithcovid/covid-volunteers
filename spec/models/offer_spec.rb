require 'rails_helper'

RSpec.describe Offer, type: :model do
  it 'factory is valid' do
    user = create(:user)
    offer = build(:offer, user: user)
    expect(offer).to be_valid
  end

  it 'is invalid without a user' do
    offer = build(:offer, user: nil)
    expect(offer).to_not be_valid
  end

  describe '#to_param' do
  	let(:user) { build(:user) }
  	let(:offer) { build(:offer, user: user) }

		it 'should parameterize id' do
			expect(offer.to_param).to eq("#{offer.id}-#{offer.name.parameterize}")
		end
  end
end
