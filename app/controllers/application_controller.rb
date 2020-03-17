class ApplicationController < ActionController::Base
  def ensure_admin
    current_user && current_user.is_admin?
  end
end
