require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'factory is valid' do
    expect(user).to be_valid
  end

  context 'without email' do
    let(:user) { build(:user, email: nil) }

    it 'is invalid' do
      expect(user).to_not be_valid
    end
  end

  context 'without password' do
    let(:user) { build(:user, password: nil) }

    it 'is invalid' do
      expect(user).to_not be_valid
    end
  end

  context 'when updating a user' do
    before { user.save! }

    context 'without skills' do
      before { user.skill_list.add([]) }
    
      it 'is invalid' do
        pending 'FIXME was this behavior changed?'
        expect(user).to_not be_valid
      end
    end

    context 'with skills' do
      before { user.skill_list.add(['Analytics']) }
    
      it 'is valid' do
        expect(user).to be_valid
      end
    end
  end

  describe '#has_complete_profile?' do
    context 'when user has incomplete profile' do
      it 'it returns false' do
        expect(user.has_complete_profile?).to eq(false)
      end
    end

    context 'when a user has a complete profile' do
      let(:user) { build(:user_complete_profile) }

      it 'returns true' do
        expect(user.has_complete_profile?).to eq(true)
      end
    end
  end

  describe '#has_correct_skills?' do
    let(:project) { create(:project, user: user, skill_list: ['Design']) }

    context 'when user does not have correct skills' do
      let(:user) { create(:user, skill_list: ['Legal']) }

      it 'returns false' do
        expect(user.has_correct_skills?(project)).to eq(false)  
      end
    end  

    context 'when user has correct skills' do
      let(:user) { create(:user, skill_list: ['Design']) }

      it 'returns true' do
        expect(user.has_correct_skills?(project)).to eq(true)  
      end
    end

    context 'when project requires "Anything"' do
      let(:project) { create(:project, user: user, skill_list: ['Anything']) }

      it 'returns true' do
        expect(user.has_correct_skills?(project)).to eq(true)  
      end
    end
  end
end
