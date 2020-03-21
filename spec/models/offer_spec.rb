require 'rails_helper'

RSpec.describe Offer, type: :model do
  it 'factory is valid' do
    user = FactoryBot.create(:user)
    offer = FactoryBot.build(:offer, user: user)
    expect(offer).to be_valid
  end

  it 'is invalid without a user' do
    offer = FactoryBot.build(:offer, user: nil)
    expect(offer).to_not be_valid
  end
end
