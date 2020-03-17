class ApplicationController < ActionController::Base
  def ensure_admin
    redirect_to projects_path if !current_user || !current_user.is_admin?
  end
end
