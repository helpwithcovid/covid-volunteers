class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy, :toggle_volunteer ]

  before_action :set_project, only: [ :show, :edit, :update, :destroy, :toggle_volunteer ]

  def index
    @projects = Project.all.reverse
    @projects_header = 'All Projects'
    @projects_subheader = 'These projects were posted by the community and looking for help.'
  end

  def volunteered
    @projects = current_user.volunteered_projects.reverse
    @projects_header = 'Volunteered Projects'
    @projects_subheader = 'These are the projects where you volunteered.'
    render action: 'index'
  end

  def own
    @projects = current_user.projects.reverse
    @projects_header = 'Own Projects'
    @projects_subheader = 'These are the projects you created.'
    render action: 'index'
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    @project.user = current_user

    respond_to do |format|
      if @project.save
        Rails.logger.error @project.errors.inspect
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_volunteer
    if @project.volunteered_users.include?(current_user)
      @project.volunteers.where(user: current_user).destroy_all
      flash[:notice] = "We've removed you from the list of volunteered people."
    else
      @project.volunteered_users << current_user

      ProjectMailer.with(project: @project, user: current_user).new_volunteer.deliver_now

      flash[:notice] = "Thanks for volunteering! The project owners will be alerted."
    end

    redirect_to project_path(@project)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.fetch(:project, {}).permit(:name, :description, :participants, :looking_for, :location)
    end
end
