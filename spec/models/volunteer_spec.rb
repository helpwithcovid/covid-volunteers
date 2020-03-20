require 'rails_helper'

RSpec.describe Volunteer, type: :model do
  it "works" do
    user = create(:user)
    project = create(:project)
    volunteer = build(:volunteer, user: user, project: project)
    expect(volunteer.valid?).to eq(true)
  end
end
