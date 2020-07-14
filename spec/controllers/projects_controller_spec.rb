require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:project) { create(:project, user: user) }
  let(:valid_params) { { project: { name: 'My Project Name', status: Settings.project_statuses.first } } }

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

    describe 'Volunteering' do
      let!(:no_volunteers_project) { create(:project, user: user, accepting_volunteers: false) }

      it 'filters by ?accepting_volunteers=0' do
        get :index, params: { accepting_volunteers: '0' }
        expect(response).to be_successful
        expect(assigns(:projects)).to include(no_volunteers_project)
        expect(assigns(:projects)).to_not include(project)
      end

      it 'filters by ?accepting_volunteers=1' do
        get :index, params: { accepting_volunteers: '1' }
        expect(response).to be_successful
        expect(assigns(:projects)).to_not include(no_volunteers_project)
        expect(assigns(:projects)).to include(project)
      end

      it 'shows projects filtered by status' do
        project.update_attribute(:status, Settings.project_statuses.last)
        project2 = create(:project, user: user, status: Settings.project_statuses.first)
        get :index, params: { status: Settings.project_statuses.last }
        expect(assigns(:projects)).to include(project)
        expect(assigns(:projects)).to_not include(project2)
      end
    end

    it 'shows highlighted projects only' do
      project.update_attribute(:highlight, true)
      reg_project = create(:project, user: user, highlight: false)
      get :index, params: { highlight: true }
      expect(response).to be_successful
      expect(assigns(:projects)).to include(project)
      expect(assigns(:projects)).to_not include(reg_project)
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
      expect(json['name']).to eq(project.name)
      expect(json['description']).to eq(project.description)
      expect(json['volunteer_location']).to eq(project.volunteer_location)
      expect(json['accepting_volunteers']).to eq(project.accepting_volunteers)
      expect(json['to_param']).to eq(project.to_param)
    end

    describe 'Volunteering' do
      it 'hide volunteer info' do
        project.number_of_volunteers = '100'
        project.accepting_volunteers = false
        project.save
        get :show, params: { id: project.to_param }
        expect(response).to be_successful
        expect(response.body).to_not include('Number of volunteers')
        expect(response.body).to_not include('Sign up to volunteer')
      end

      it 'show volunteer info' do
        project.number_of_volunteers = '100'
        project.accepting_volunteers = true
        project.save
        get :show, params: { id: project.to_param }
        expect(response).to be_successful
        expect(response.body).to include('Number of volunteers')
        expect(response.body).to include('Sign up to volunteer')
      end

      it 'shows volunteer button if your profile is complete' do
        user = create(:user_complete_profile)
        sign_in user
        user.skill_list.add('Design')
        user.save
        project.skill_list.add('Design')
        project.save
        get :show, params: { id: project.to_param }
        expect(response.body).to include('volunteers-btn')
      end

      it 'shows volunteer filled button if you dont have the right skills' do
        user = create(:user_complete_profile)
        sign_in user
        get :show, params: { id: project.to_param }
        expect(response.body).to include('volunteers-filled-btn')
      end
    end
  end

  describe 'GET #new' do
    it 'works' do
      sign_in user
      get :new
      expect(response).to be_successful
    end

    it 'redirects you if signed out' do
      get :new
      expect(response).to_not be_successful
    end

    it 'tracks an event' do
      sign_in user
      expect(controller).to receive(:track_event).with('Project creation started').and_call_original
      get :new
      # This doesn't work since the GET request sets and deletes the variable within same request
      # expect(session[:track_event]).to eq('Project creation started')
      expect(response.body).to match(/Project creation started/)
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
      sign_in user
      post :create, params: valid_params
      expect(assigns(:project)).to be_present
      expect(response).to be_redirect
    end

    it 'tracks an event' do
      sign_in(user)
      post :create, params: valid_params
      expect(session[:track_event]).to eq('Project creation complete')
    end
  end

  describe 'PUT #update' do
    it 'updating accepting_volunteers works' do
      sign_in user
      expect(project.accepting_volunteers).to eq(true)
      put :update, params: { id: project.id, project: { accepting_volunteers: false } }
      expect(response).to be_redirect
      expect(assigns(:project).accepting_volunteers).to eq(false)
    end
  end

  describe 'DELETE #destroy' do
    it 'works' do
      pending 'TODO'
      fail
    end
  end

  describe 'POST #toggle_volunteer' do
    it 'volunteers you if you are not currently a volunteer' do
      pending 'TODO'
      fail
    end

    it 'tracks an event if you are not currently a volunteer' do
      pending 'TODO'
      fail
    end

    it 'unvolunteers you if you had already volunteered' do
      pending 'TODO'
      fail
    end
  end
end
