require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }
  let(:project) { build(:project, user: user) }

  it 'factory is valid' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is invalid without email' do
    user = build(:user, email: nil)
    expect(user).to_not be_valid
  end

  it 'is invalid without password' do
    user = build(:user, password: nil)
    expect(user).to_not be_valid
  end

  describe 'Complete profile' do
    it 'is incomplete' do
      user = build(:user, profile_links: 'test', location: 'test')
      expect(user.has_complete_profile?).to eq(false)
    end

    it 'is complete' do
      user = build(:user, about: 'test', profile_links: 'test', location: 'test')
      expect(user.has_complete_profile?).to eq(true)
    end

    it 'doesnt have right skills for project' do
      user.skill_list.add(['Engineer'])
      user.save!
      project.skill_list.add(['Design'])
      project.save!
      expect(user.has_correct_skills?(project)).to eq(false)
    end

    it 'has right skills for project' do
      user.skill_list.add(['Design', 'Engineer'])
      user.save!
      project.skill_list.add(['Design'])
      project.save!
      expect(user.has_correct_skills?(project)).to eq(true)
    end

    it 'has right skills if project requires `Anything`' do
      project.skill_list.add(['Anything'])
      project.save!
      expect(user.has_correct_skills?(project)).to eq(true)
    end
  end
end
