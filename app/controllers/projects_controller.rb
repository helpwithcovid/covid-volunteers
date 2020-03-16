class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
    @projects_header = 'All Projects'
    @projects_subheader = 'These projects were posted by the community and looking for help.'
  end

  def liked
    @projects = current_user.liked
    @projects_header = 'Liked Projects'
    @projects_subheader = 'These projects were liked (favorited) by you.'
    render action: 'index'
  end

  def own
    @projects = current_user.projects
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
