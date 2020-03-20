class AdminController < ApplicationController
  before_action :ensure_admin

  def delete_user
    @user = User.find(params[:user_id])
    @user.destroy if @user

    redirect_to volunteers_path
  end

  def toggle_highlight
    @project = Project.find(params[:project_id])
    @project.highlight = !@project.highlight
    @project.save

    redirect_to project_path(@project)
  end

  def dashboard
  end
end
