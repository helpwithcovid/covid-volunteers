class Admin::VolunteerGroupsController < ApplicationController
  before_action :ensure_admin
  before_action :set_project, only: [ :new, :create, :generate_volunteers ]

  def new
    @volunteer_group = VolunteerGroup.new({ project: @project })
  end

  def create
    @volunteer_group = VolunteerGroup.new({ project: @project })

    if params[:volunteer_group] && params[:volunteer_group][:user_ids]
      @volunteer_group.assigned_user_ids = params[:volunteer_group][:user_ids]
      @volunteer_group.save

      params[:volunteer_group][:user_ids].each do |user_id|
        user = User.where(id: user_id).last

        @project.volunteered_users << user unless @project.volunteered_users.include?(user)
      end

      flash[:notice] = 'Volunteers assigned and invitation sent.'
    else
      flash[:error] = 'No volunteers assigned so not doing anything.'
    end

    redirect_to project_path(@project)
  end

  def generate_volunteers
    @users = User.where('id != ?', @project.user_id)
    @users = @users.where(pair_with_projects: true)
    @users = @users.where.not(id: params[:user_ids])
    @users = @users.where.not(id: params[:rejected_user_ids])
    @users = @users.where.not(id: @project.volunteers.collect { |v| v.user_id })
    @users = @users.tagged_with(@project.skill_list, any: true)
    @users = @users.order('RANDOM()')
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
