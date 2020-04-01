require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'factory is valid' do
    user = FactoryBot.create(:user)
    project = FactoryBot.build(:project, user: user)
    expect(project).to be_valid
  end

  it 'is invalid without a user' do
    project = FactoryBot.build(:project, user: nil)
    expect(project).to_not be_valid
  end

  it 'accepting_volunteers defaults true' do
    project = FactoryBot.build(:project, user: nil)
    expect(project.accepting_volunteers).to eq(true)
  end
end
