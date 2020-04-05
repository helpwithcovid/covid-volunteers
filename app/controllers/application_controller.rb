class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :hydrate_project_groups
  before_action :set_global_announcements

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

  def remove_global_announcements
    @global_announcements = nil
  end

  def set_global_announcements
    @global_announcements = [
      {
        title: 'Helpful resources for your projects',
        sub_title: 'We wrote a playbook on how to manage volunteers, had some amazing panels, and gathered some deals for you.',
        cta_text: 'Browse resources',
        cta_url: '/offers',
      }
    ]
  end

  def hydrate_project_groups
    @project_groups = Settings.project_groups

    @project_groups.each do |group|
      group[:featured_projects] = Rails.cache.fetch("project_group_#{group[:name].downcase}_featured_projects", expires_in: 1.hour) { Project.tagged_with(group[:project_skills]).take 3 }
      group[:projects_count] = Rails.cache.fetch("project_group_#{group[:name].downcase}_projects_count", expires_in: 1.hour) { Project.tagged_with(group[:project_skills]).count }
    end
  end
end
