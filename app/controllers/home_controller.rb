class HomeController < ApplicationController
  before_action :hide_global_announcements

  def index
    @project_count = Rails.cache.fetch('project_count', expires_in: 1.hour) { Project.count }.tap { |count| (count / 50).floor * 50 }
    @volunteer_count = Rails.cache.fetch('volunteer_count', expires_in: 1.hour) { User.count }.tap { |count| (count / 100).floor * 50 }
    @featured_projects = Rails.cache.fetch('featured_projects', expires_in: 1.hour) { Project.take 3 }
  end
end
