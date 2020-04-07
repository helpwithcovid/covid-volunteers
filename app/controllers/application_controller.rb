class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
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

  def track_event(action)
    session[:track_event] = action
  end

  def pop_event_to_track
    session.delete(:track_event)
  end
  helper_method :pop_event_to_track
end
