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

    it 'returns json' do
      get :index, format: 'json'
      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json[0]['name']).to be_present
      expect(json[0]['description']).to be_present
      expect(json[0]['to_param']).to be_present
    end
  end

  describe 'GET #show' do
    it 'works' do
      # get :show, project.id
      get :show, params: { id: project.to_param }
      expect(response).to be_successful
      expect(assigns(:project)).to eq(project)
    end

    it 'returns json' do
      get :show, params: { id: project.to_param }, format: 'json'
      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json["name"]).to eq(project.name)
      expect(json["description"]).to eq(project.description)
      expect(json["location"]).to eq(project.location)
      expect(json["to_param"]).to eq(project.to_param)
    end
  end

  describe 'GET #new' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'GET #edit' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'POST #create' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'PUT #update' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end


  describe 'DELETE #destroy' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end



end
