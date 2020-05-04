class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :show_global_announcements
  before_action :set_bg_gray

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

  def set_bg_gray
    @bg_color = 'bg-gray-100'
  end

  def set_bg_white
    @bg_color = 'bg-white'
  end

  private
    def hydrate_project_categories
      @project_categories = Settings.project_categories

      exclude_ids = []
      @project_categories.each do |category|
        exclude_ids.flatten!
        category[:featured_projects] = Rails.cache.fetch("project_category_#{category[:name].downcase}_featured_projects", expires_in: 1.hour) { Project.where(highlight: true).includes(:project_types, :skills, :volunteers).where.not(id: exclude_ids).tagged_with(category[:project_types], any: true, on: :project_types).limit(3).order('RANDOM()') }
        exclude_ids << category[:featured_projects].map(&:id)
        category[:projects_count] = Rails.cache.fetch("project_category_#{category[:name].downcase}_projects_count", expires_in: 1.hour) { Project.tagged_with(category[:project_types], any: true, on: :project_types).count }
      end
    end

    def track_event(event_name)
      session[:track_event] = event_name
    end
end
