class HomeController < ApplicationController
  before_action :hydrate_project_categories
  before_action :hide_global_announcements
  before_action :set_bg_white

  def index
    @project_count = Rails.cache.fetch('project_count', expires_in: 1.day) do
      Project.count
    end

    @volunteer_count = Rails.cache.fetch('volunteer_count', expires_in: 1.day) do
      User.count
    end

    @featured_projects = Project.get_featured_projects
  end
end
