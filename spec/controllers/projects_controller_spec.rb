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
      expect(json[0]["name"]).to eq(project.name)
      expect(json[0]["description"]).to eq(project.description)
      expect(json[0]["location"]).to eq(project.location)
      expect(json[0]["to_param"]).to eq(project.to_param)
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
      expect(json["accepting_volunteers"]).to eq(project.accepting_volunteers)
      expect(json["to_param"]).to eq(project.to_param)
    end

    describe 'Volunteering' do
      it 'hide volunteer info' do
        project.number_of_volunteers = "100";
        project.accepting_volunteers = false
        project.save
        get :show, params: { id: project.to_param }
        expect(response).to be_successful
        expect(response.body).to_not include("Number of volunteers")
      end

      it 'show volunteer info' do
        project.number_of_volunteers = "100";
        project.accepting_volunteers = true
        project.save
        get :show, params: { id: project.to_param }
        expect(response).to be_successful
        expect(response.body).to include("Number of volunteers")
      end
    end

  end

  describe 'GET #new' do
    it 'works' do
      sign_in user
      get :new
      expect(response).to be_successful
    end

    it 'defaults new projects with accepting_volunteers=true' do
      sign_in user
      get :new
      expect(assigns(:project).accepting_volunteers).to eq(true)
    end

    it 'redirects you if signed out' do
      get :new
      expect(response).to_not be_successful
    end
  end

  describe 'GET #edit' do
    it 'works' do
      sign_in user
      get :edit, params: { id: project.id }
      expect(response).to be_successful
    end

    it 'fails if not signed in' do
      get :edit, params: { id: project.id }
      expect(response).to_not be_successful
    end
  end

  describe 'POST #create' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'PUT #update' do
    it 'updating accepting_volunteers works' do
      sign_in user
      expect(project.accepting_volunteers).to_not eq(true)
      put :update, params: { id: project.id, project: { accepting_volunteers: true } }
      expect(response).to be_redirect
      expect(assigns(:project).accepting_volunteers).to eq(true)
    end
  end

  describe 'DELETE #destroy' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end



end
