class Admin::VolunteerGroupsController < ApplicationController
  before_action :ensure_admin
  before_action :set_project, only: [ :new, :create, :generate_volunteers ]

  def new
    @volunteer_group = VolunteerGroup.new({ project: @project })
  end

  def generate_volunteers
    @users = User.all.sample(10)

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
