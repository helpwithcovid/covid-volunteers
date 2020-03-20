require 'rails_helper'

RSpec.describe User, type: :model do
  it "factory is valid" do
    user = FactoryBot.build(:user)
    expect(user).to be_valid
  end

  it "is invalid without email" do
    user = FactoryBot.build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it "is invalid without password" do
    user = FactoryBot.build(:user, password: nil)
    expect(user).to_not be_valid
  end

end
