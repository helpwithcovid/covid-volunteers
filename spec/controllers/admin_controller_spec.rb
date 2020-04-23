require 'rails_helper'

RSpec.describe AdminController, type: :controller do
  let!(:user) { create(:user) }
  let!(:admin) { User.where(email: ADMINS[0]).first || create(:user, email: ADMINS[0]) }

  describe 'POST #delete_user' do
    let!(:valid_params) { { user_id: user.to_param } }

    # TODO refactor to account for shared `ensure_admin` filter
    # Then just test that each method calls `ensure_admin`, like so
    it 'calls ensure_admin' do
      expect(controller).to receive(:ensure_admin)
      post :delete_user, params: valid_params
    end

    it "returns 401 Unauthorized if you're not logged in" do
      post :delete_user, params: valid_params
      expect(response).to redirect_to(projects_path)
    end

    it "returns 401 unauthorized if you're logged in but not an admin" do
      sign_in(user)
      post :delete_user, params: valid_params
      expect(response).to redirect_to(projects_path)
    end

    it "works if you're signed-in as an admin" do
      sign_in(admin)
      post :delete_user, params: valid_params
      expect(response).to redirect_to(volunteers_path)
      expect(flash[:notice]).to match(/User deleted/)
    end

    it "fails if you don't specify a valid user's id" do
      sign_in(admin)
      expect(User.where(id: 666)).to be_blank
      expect {
        post :delete_user, params: { user_id: 666 }
        expect(response.status).to eq(404)
      }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end

  describe 'POST #toggle_highlight' do
    let!(:project) { create(:project, user: user) }
    let!(:valid_params) { { project_id: project.to_param } }

    it 'calls ensure_admin' do
      expect(controller).to receive(:ensure_admin)
      post :toggle_highlight, params: valid_params
    end

    it 'highlights if project is not currently highlighted. highlit? highlighted' do
      sign_in(admin)
      expect(project.highlight?).to eq(false)
      post :toggle_highlight, params: valid_params
      expect(response).to redirect_to(project_path(project))
      expect(project.reload.highlight?).to eq(true)
      expect(flash[:notice]).to match(/Project highlighted/)
    end

    it 'unhighlights if project was already highlighted' do
      sign_in(admin)
      active_project = create(:project, user: user, highlight: true)
      expect(active_project.highlight?).to eq(true)
      post :toggle_highlight, params: { project_id: active_project.to_param }
      expect(response).to redirect_to(project_path(active_project))
      expect(active_project.reload.highlight?).to eq(false)
      expect(flash[:notice]).to match(/Removed highlight/)
    end
  end
end
