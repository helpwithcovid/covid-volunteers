# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  let!(:user) { FactoryBot.create(:user) }
  let!(:project) { FactoryBot.create(:project, user: user, highlight: true) }

  describe '#index' do
    it 'works' do
      get :index
      expect(assigns(:featured_projects)).to include(project)
      expect(response).to be_successful
    end

    it 'works when signed in' do
      sign_in(user)
      get :index
      expect(response).to be_successful
    end
  end
end
