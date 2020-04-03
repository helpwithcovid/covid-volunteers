class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

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

  def set_global_announcements
    @global_announcement = [
      {
        title: 'Resources for your project',
        sub_title: 'From webinars on How to Scale Volunteers, management playbook, to office hours, offers and more.',
        cta_text: 'View Resources',
        cta_url: offers_path
      }
    ]
  end

  def show_global_announcements
    @show_global_announcements = true
  end
end
