class HomeController < ApplicationController
  before_action :hydrate_project_groups

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
    @featured_projects = Project.where(highlight: true).order('RANDOM()').take 3

    @projects_header = "#{CITY_NAME} Residents vs. COVID-19"
    @projects_subheader = "This is a #{CITY_NAME}-wide partnership platform, where #{CITY_NAME} residents can volunteer (in-person or remotely) and local non-profits and government can post volunteer needs. Let us unite and fight the pandemic together!"
  end

  private
    def hydrate_project_groups
      @project_groups = Settings.project_groups

      @project_groups.each do |group|
        group[:featured_projects] = Rails.cache.fetch("project_group_#{group[:name].downcase}_featured_projects", expires_in: 1.hour) { Project.where(highlight: true).tagged_with(group[:project_types], any: true, on: :project_types).take 3 }
        group[:projects_count] = Rails.cache.fetch("project_group_#{group[:name].downcase}_projects_count", expires_in: 1.hour) { Project.tagged_with(group[:project_types], any: true, on: :project_types).count }
      end
    end
end
