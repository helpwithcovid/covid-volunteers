# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  render_views

  let!(:user) { create(:user) }
  let!(:project) { create(:project, user: user, highlight: true) }

  describe '#index' do
    it 'works' do
      # Since we randomize projects on the homepage, we need to delete all existing projects
      # to make sure our new project shows up in @featured_projects. Not graceful but it works
      Project.delete_all
      new_project = FactoryBot.create(:project, user: user, highlight: true)
      expect(Project.count).to eq(1)

      get :index
      expect(assigns(:featured_projects)).to include(new_project)
      expect(response).to be_successful
    end

    it 'works when signed in' do
      sign_in(user)
      get :index
      expect(response).to be_successful
    end

    it 'doesnt show the same featured project twice' do
      project2 = create(:project_with_type, user: user, highlight: true, project_type_list: ['Track the outbreak', 'Scale testing'])
      get :index
      featured_ids = assigns(:project_categories).map(&:featured_projects).flatten.map(&:id)
      expect(featured_ids.count(project2.id)).to eq(1)
    end
  end
end
