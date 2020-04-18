require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  let!(:user) { create(:user) }
  let!(:project) { create(:project, user: user) }

  it 'factory is valid, given valid associations' do
    # Note that user is volunteering for their own project, but this is allowed
    volunteer = build(:volunteer, user: user, project: project)
    expect(volunteer.valid?).to eq(true)
  end

  it 'is invalid without a user' do
    volunteer = build(:volunteer, user: nil, project: project)
    expect(volunteer.valid?).to eq(false)
  end

  it 'is invalid without a project' do
    volunteer = build(:volunteer, user: user, project: nil)
    expect(volunteer.valid?).to eq(false)
  end
end
