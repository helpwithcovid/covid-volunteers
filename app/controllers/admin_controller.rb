class AdminController < ApplicationController
  before_action :ensure_admin

  def delete_user
    @user = User.find(params[:user_id])
    @user.destroy!

    flash[:notice] = "User deleted"
    redirect_to volunteers_path
  end

  def toggle_highlight
    @project = Project.find(params[:project_id])
    @project.highlight = !@project.highlight
    @project.save

    flash[:notice] = @project.highlight? ? "Project highlighted" : "Removed highlight on project"
    redirect_to project_path(@project)
  end

  private
end