require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
# RSpec.describe ProjectsController do
  # render_views

  let(:valid_attributes){ { name: "ok", email: "ok@ok.com"} }
  let(:valid_session){ {} }

  describe 'GET #index' do
    it 'works' do
      get :index, params: {}, session: valid_session
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'works' do
      get :show, id: 1
      expect(response).to be_success
      expect assigns(:project).to be_present
    end
  end



end
