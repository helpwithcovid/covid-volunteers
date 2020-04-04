class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :set_project_groups

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

  def set_project_groups
    @project_groups = Rails.cache.fetch('project_groups', expires_in: 1.hour) do
      groups = [
        {
          title: 'Prevention',
          body: 'Inform, reduce, and control the spread of the outbreak',
          project_skills: ['Reduce spread', 'Scale testing'],
          icon: 'medical',
          featured: true,
          featured_projects: [],
        },
        {
          title: 'Medical',
          body: 'Support our overwhelmed health systems with medical innovation',
          project_skills: ['Medical facilities', 'Medical equipments'],
          icon: 'medical',
          featured: true,
          featured_projects: [],
        },
        {
          title: 'Community',
          body: 'Work together to help our stressed communities',
          project_skills: ['Social giving', 'Help out communities'],
          icon: 'medical',
          featured: true,
          featured_projects: [],
        },
      ]
    end

    groups.map do |group|
      group[:featured_projects] = Project.tagged_with(group[:project_skills]).take 9
      group[:projects_count] = Project.tagged_with(group[:project_skills]).count
    end

    groups
  end

  def show_global_announcements
    @show_global_announcements = true
  end
end
