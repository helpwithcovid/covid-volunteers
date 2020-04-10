class HomeController < ApplicationController
  before_action :hydrate_project_groups
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
    def hydrate_project_groups
      @project_groups = Settings.project_groups

      exclude_ids = []
      @project_groups.each do |group|
        exclude_ids.flatten!
        group[:featured_projects] = Rails.cache.fetch("project_group_#{group[:name].downcase}_featured_projects", expires_in: 1.hour) { Project.where(highlight: true).where.not(id: exclude_ids).tagged_with(group[:project_types], any: true, on: :project_types).limit(3).order('RANDOM()') }
        exclude_ids << group[:featured_projects].map(&:id)
        group[:projects_count] = Rails.cache.fetch("project_group_#{group[:name].downcase}_projects_count", expires_in: 1.hour) { Project.tagged_with(group[:project_types], any: true, on: :project_types).count }
      end
    end
end
