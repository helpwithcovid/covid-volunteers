class AdminController < ApplicationController
  before_action :ensure_admin

  def delete_project
    @project = Project.find(params[:project_id])
    @project.destroy if @project

    redirect_to projects_path
  end

  def delete_user
    @user = User.find(params[:user])
    @user.destroy if @user

    redirect_to volunteers_path
  end
end
