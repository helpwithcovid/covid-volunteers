require 'rails_helper'

RSpec.describe Business, 'type: :model' do
	
	it 'has a valid factory' do
	  business = build(:business)

	  expect(business).to be_valid
	end

  context 'validations' do
  	subject { build(:business) }

  	it { should belong_to(:user) }

  	it { is_expected.to validate_presence_of(:name) }

  	it { is_expected.to validate_uniqueness_of(:name) }
  end

  


end
