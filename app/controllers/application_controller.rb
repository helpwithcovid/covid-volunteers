class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception

  def ensure_admin
    redirect_to projects_path if !current_user || !current_user.is_admin?
  end
end
