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

    it 'doesnt show the same featured project twice' do
      project2 = FactoryBot.create(:project_with_type, user: user, highlight: true, project_type_list: ['Track the outbreak', 'Scale testing'])
      get :index
      featured_ids = assigns(:project_groups).map(&:featured_projects).flatten.map(&:id)
      expect(featured_ids.count(project2.id)).to eq(1)
    end
  end
end
