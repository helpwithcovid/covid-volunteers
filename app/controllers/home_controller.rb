class HomeController < ApplicationController
  before_action :hydrate_project_categories
  before_action :hide_global_announcements

  def index
    @project_count = Rails.cache.fetch('project_count', expires_in: 1.day) do
      Project.count
    end
    # Display the projects in increments of 50
    @project_count = (@project_count / 50).floor * 50

    @volunteer_count = Rails.cache.fetch('volunteer_count', expires_in: 1.day) do
      User.count
    end
    # Display the volunteers in increments of 100
    @volunteer_count = (@volunteer_count / 100).floor * 100
    @featured_projects = Project.where(highlight: true).limit(3).order('RANDOM()')
  end

  private
    def set_bg_color
      @bg_color = 'white'
    end
end
