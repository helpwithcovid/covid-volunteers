class HomeController < ApplicationController
  before_action :hydrate_project_categories

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
    @projects_all = Project.all.order('RANDOM()').take 3

    @projects_header = "#{CITY_NAME} Residents vs. COVID-19"
    @projects_subheader = "This is a #{CITY_NAME}-wide partnership platform, where #{CITY_NAME} residents can volunteer (in-person or remotely) and local non-profits and government can post volunteer needs. Let us unite and fight the pandemic together!"
  end

  private
    def hydrate_project_categories
      @project_categories = Settings.project_categories

      @project_categories.each do |category|
        category[:featured_projects] = Rails.cache.fetch("project_category_#{category[:name].downcase}_projects", expires_in: 1.hour) {
        	puts category[:project_types]
        	projects_with_skills = Project.tagged_with(category[:project_types], any: true, on: :project_types)
        	projects_with_locations = Project.where(location: category[:project_types])
        	relevant_projects = projects_with_skills + projects_with_locations
        	puts relevant_projects
        	relevant_projects.take 3
        }
        category[:projects_count] = Rails.cache.fetch("project_category_#{category[:name].downcase}_projects_count", expires_in: 1.hour) {
            projects_with_skills = Project.tagged_with(category[:project_types], any: true, on: :project_types)
        	projects_with_locations = Project.where(location: category[:project_types])
        	relevant_projects = projects_with_skills + projects_with_locations
        	relevant_projects.count
        }
      end
    end
end
