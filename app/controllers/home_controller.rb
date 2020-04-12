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
    def hydrate_project_categories
      @project_categories = Settings.project_categories

      exclude_ids = []
      @project_categories.each do |category|
        exclude_ids.flatten!
        category[:featured_projects] = Rails.cache.fetch("project_category_#{category[:name].downcase}_featured_projects", expires_in: 1.hour) { Project.where(highlight: true).where.not(id: exclude_ids).tagged_with(category[:project_types], any: true, on: :project_types).limit(3).order('RANDOM()') }
        exclude_ids << category[:featured_projects].map(&:id)
        category[:projects_count] = Rails.cache.fetch("project_category_#{category[:name].downcase}_projects_count", expires_in: 1.hour) { Project.tagged_with(category[:project_types], any: true, on: :project_types).count }
      end
    end
end
