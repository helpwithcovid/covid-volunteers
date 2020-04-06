class HomeController < ApplicationController
  before_action :hydrate_project_groups
  before_action :hide_global_announcements

  def index
    # Display the projects in increments of 50
    @project_count = Rails.cache.fetch('project_count', expires_in: 1.day) { Project.count }.tap { |count| (count / 50).floor * 50 }
    # Display the volunteers in increments of 50
    @volunteer_count = Rails.cache.fetch('volunteer_count', expires_in: 1.day) { User.count }.tap { |count| (count / 100).floor * 50 }
    @featured_projects = Rails.cache.fetch('featured_projects', expires_in: 1.day) { Project.where(highlight: true).order('RANDOM()').take 3 }
  end

  private
    def hydrate_project_groups
      @project_groups = Settings.project_groups

      @project_groups.each do |group|
        group[:featured_projects] = Rails.cache.fetch("project_group_#{group[:name].downcase}_featured_projects", expires_in: 1.hour) { Project.where(highlight: true).tagged_with(group[:project_types], any: true).take 3 }
        group[:projects_count] = Rails.cache.fetch("project_group_#{group[:name].downcase}_projects_count", expires_in: 1.hour) { Project.where(highlight: true).tagged_with(group[:project_types], any: true).count }
      end
    end
end
