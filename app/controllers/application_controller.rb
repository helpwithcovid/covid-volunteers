class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :hydrate_project_groups
  before_action :show_global_announcements

  def ensure_admin
    redirect_to projects_path if !current_user || !current_user.is_admin?
  end

  def set_filters_open
    @filters_open = case cookies['filters_open']
                    when 'nil'
                    when true
                    when 'true'
                      true
                    when false
                    when 'false'
                      false
                    else
                      true
                    end
  end

  def hide_global_announcements
    @show_global_announcements = false
  end

  def show_global_announcements
    @show_global_announcements = true
  end

  def hydrate_project_groups
    @project_groups = Settings.project_groups

    @project_groups.each do |group|
      group[:featured_projects] = Rails.cache.fetch("project_group_#{group[:name].downcase}_featured_projects", expires_in: 1.hour) { Project.tagged_with(group[:project_skills]).take 3 }
      group[:projects_count] = Rails.cache.fetch("project_group_#{group[:name].downcase}_projects_count", expires_in: 1.hour) { Project.tagged_with(group[:project_skills]).count }
    end
  end
end
