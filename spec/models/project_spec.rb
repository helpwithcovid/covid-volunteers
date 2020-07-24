require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:user) { build(:user) }
  let(:project) { build(:project, user: user) }

  it 'factory is valid' do
    user = create(:user)
    project = build(:project, user: user)
    expect(project).to be_valid
  end

  it 'is invalid without a name' do
    project = build(:project, name: nil)
    expect(project).to_not be_valid
  end

  it 'is invalid without a user' do
    project = build(:project, user: nil)
    expect(project).to_not be_valid
  end

  it 'accepting_volunteers defaults true' do
    project = build(:project, user: nil)
    expect(project.accepting_volunteers).to eq(true)
  end

  describe 'can_edit?' do
    it 'random user cant edit' do
      expect(project.can_edit?(build(:user))).to eq(false)
    end

    it 'project_owner can edit' do
      project_owner = project.user
      expect(project.can_edit?(project_owner)).to eq(true)
    end

    it 'admin can edit' do
      admin_user = build(:user_admin)
      expect(project.can_edit?(admin_user)).to eq(true)
    end
  end

  describe 'Category & Cover photo' do
    Settings.project_categories.each do |category|
      category['project_types'].to_a.each do |type|
        it "#{type} returns #{category.name}" do
          project.project_type_list.add(type)
          expect(project.category).to eq(category.name)
        end
      end
    end

    it 'project defaults to medical with no type' do
      expect(project.category).to eq('Community')
    end

    describe '#cover_photo' do
      let(:subject) { project.cover_photo(name)}
      let(:helpers) { double() }

      before do 
        allow(ActionController::Base).to receive(:helpers).and_return(helpers)
        allow(helpers).to receive(:asset_pack_path)
      end

      context 'when no filename is provided' do
        let(:name) { nil }

        it 'calls asset_pack_path with the correct parameter' do
          project.project_type_list.add('Reduce spread')

          expect(helpers).to receive(:asset_pack_path).with('media/images/prevention-default.png')

          subject
        end
      end

      context 'when a filename is provided' do
        let(:name) { 'Test' }

        it 'calls asset_pack_path with the correct parameter' do
          expect(helpers).to receive(:asset_pack_path).with('media/images/test-default.png')

          subject
        end
      end
    end
  end

  it 'it sets default status' do
    project = build(:project, status: nil)
    project.save
    expect(project.status).to eq(Settings.project_statuses.first)
  end

  it 'is invalid without a status' do
    project = build(:project, status: nil)
    expect(project).to_not be_valid
  end

  it 'is invalid with wrong status' do
    project = build(:project, status: 'lol')
    expect(project).to_not be_valid
  end
end
