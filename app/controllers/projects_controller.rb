class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy, :toggle_volunteer, :update_volunteer, :volunteered, :own, :volunteers ]
  before_action :set_project, only: [ :show, :edit, :update, :destroy, :toggle_volunteer, :volunteers, :update_volunteer ]
  before_action :ensure_owner_or_admin, only: [ :edit, :update, :destroy, :volunteers, :update_volunteer ]
  before_action :set_filters_open, only: :index
  before_action :set_projects_query, only: :index

  def index
    params[:page] ||= 1
    @show_filters = true
    @show_search_bar = true
    @show_sorting_options = true

    respond_to do |format|
      format.html do
        @projects_header = 'COVID-19 projects looking for volunteers'
        @projects_subheader = 'New or established projects helping with the COVID-19 crisis that need help. Volunteer yourself or create a new one.'
        @page_title = 'All Projects'

        @projects = @projects.page(params[:page]).per(25)

        @index_from = (@projects.prev_page || 0) * @projects.current_per_page + 1
        @index_to = [@index_from + @projects.current_per_page - 1, @projects.total_count].min
        @total_count = @projects.total_count
      end
      format.json do
        render json: @projects
      end
    end
  end

  def volunteered
    params[:page] ||= 1

    @projects = current_user.volunteered_projects.page(params[:page]).per(25)
    @index_from = (@projects.prev_page || 0) * @projects.current_per_page + 1
    @index_to = [@index_from + @projects.current_per_page - 1, @projects.total_count].min

    @projects_header = 'Volunteered Projects'
    @projects_subheader = 'These are the projects where you volunteered.'
    @page_title = 'Volunteered Projects'
    render action: 'index'
  end

  def own
    params[:page] ||= 1

    @projects = current_user.projects.page(params[:page]).per(25)

    @index_from = (@projects.prev_page || 0) * @projects.current_per_page + 1
    @index_to = [@index_from + @projects.current_per_page - 1, @projects.total_count].min

    @projects_header = 'Own Projects'
    @projects_subheader = 'These are the projects you created.'
    @page_title = 'Own Projects'
    render action: 'index'
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @project }
    end
  end

  def volunteers
    respond_to do |format|
      format.csv { send_data @project.volunteered_users.to_csv, filename: "volunteers-#{Date.today}.csv" }
    end
  end

  def new
    @project = Project.new
    track_event 'Project creation started'
  end

  def create
    @project = current_user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        track_event 'Project creation complete'
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
      format.html { redirect_to projects_url, notice: 'Project was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def toggle_volunteer
    if @project.volunteered_users.include?(current_user)
      @project.volunteers.where(user: current_user).destroy_all
      flash[:notice] = "We've removed you from the list of volunteered people."
    else
      Volunteer.create(user: current_user, project: @project, note: params[:volunteer_note])

      ProjectMailer.with(project: @project, user: current_user, note: params[:volunteer_note]).new_volunteer.deliver_now

      flash[:notice] = 'Thanks for volunteering! The project owners will be alerted.'
      track_event 'User volunteered'
    end

    redirect_to project_path(@project)
  end

  def update_volunteer
    update_volunteer_params = params.fetch(:volunteer, {}).permit(:id, volunteer_abilities_attributes: [ :permission, :enabled ])

    volunteer = @project.volunteers.find(update_volunteer_params[:id])
    update_volunteer_params[:volunteer_abilities_attributes].each_pair do |idx, attrs|
      volunteer.volunteer_abilities.find_or_initialize_by(permission: attrs[:permission]).tap do |ability|
        ability.update(enabled: attrs["enabled"] == "1")
      end
    end

    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.fetch(:project, {}).permit(:name, :description, :participants, :looking_for, :contact, :volunteer_location, :target_country, :target_location, :progress, :docs_and_demo, :accepting_volunteers, :number_of_volunteers, :links, :status, :short_description, :skill_list => [], :project_type_list => [])
    end

    def ensure_owner_or_admin
      if current_user != @project.user && !current_user.is_admin?
        flash[:error] = "Apologies, you don't have access to this."
        redirect_to projects_path
      end
    end

    def set_projects_query
      applied_skills = (params[:skills] || '').split(',')
      applied_project_types = (params[:project_types] || '').split(',')

      @projects = Project
      @projects = @projects.tagged_with(applied_skills, any: params[:any]) if applied_skills.length > 0
      @projects = @projects.tagged_with(applied_project_types, any: params[:any]) if applied_project_types.length > 0
      @projects = @projects.where(accepting_volunteers: params[:accepting_volunteers] == '1') if params[:accepting_volunteers].present?
      @projects = @projects.where(highlight: true) if params[:highlight].present?
      @projects = @projects.where(target_country: params[:target_country]) if params[:target_country].present?
      @projects = @projects.where(status: params[:status]) if params[:status].present?

      if params[:query].present?
        @projects = @projects.search(params[:query]).left_joins(:volunteers).reorder(nil).group(:id)
      else
        @projects = @projects.left_joins(:volunteers).group(:id)
      end

      if params[:sort_by]
        @projects = @projects.order(get_order_param)
      else
        @projects = @projects.order('highlight DESC, COUNT(volunteers.id) DESC, created_at DESC')
      end


      @projects = @projects.includes(:project_types, :skills)
    end

    def get_order_param
      return 'created_at desc' if params[:sort_by] == 'latest'
      return 'volunteers.count asc' if params[:sort_by] == 'volunteers_needed'
    end
end
