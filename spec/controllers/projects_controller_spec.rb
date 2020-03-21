require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  render_views

  let!(:user){ FactoryBot.create(:user) }
  let!(:project){ FactoryBot.create(:project, user: user) }

  describe 'GET #index' do
    it 'works' do
      get :index
      expect(response).to be_successful
      expect(assigns(:projects)).to include(project)
    end
  end

  describe 'GET #show' do
    it 'works' do
      # get :show, project.id
      get :show, params: { id: project.to_param }
      expect(response).to be_successful
      expect(assigns(:project)).to eq(project)
    end
  end

end
