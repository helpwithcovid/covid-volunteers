class Admin::VolunteerGroupsController < ApplicationController
  before_action :ensure_admin
  before_action :set_project, only: [ :new, :create, :generate_volunteers ]

  def new
    @volunteer_group = VolunteerGroup.new({ project: @project })
  end

  def generate_volunteers
    @users = User.where('id != ?', @project.user_id)
    @users = @users.where.not(id: params[:chosen_user_ids])
    @users = @users.tagged_with(@project.skill_list, any: true)
    @users = @users.limit(10)

    respond_to do |format|
      format.json do 
        render json: { message: 'done', users: @users }
      end
    end
  end

  protected

  def set_project
    @project = Project.find(params[:project_id])
  end
end
