class HomeController < ApplicationController
  before_action :hide_global_announcements

  def index
    # Display the projects in increments of 50
    @project_count = Rails.cache.fetch('project_count', expires_in: 1.day) { Project.count }.tap { |count| (count / 50).floor * 50 }
    # Display the volunteers in increments of 50
    @volunteer_count = Rails.cache.fetch('volunteer_count', expires_in: 1.day) { User.count }.tap { |count| (count / 100).floor * 50 }
    @featured_projects = Rails.cache.fetch('featured_projects', expires_in: 1.day) { Project.where(highlight: true).order('RANDOM()').take 3 }
  end
end
