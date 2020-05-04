class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy, :toggle_volunteer, :volunteered, :own, :volunteers ]
  before_action :set_project, only: [ :show, :edit, :update, :destroy, :toggle_volunteer, :volunteers ]
  before_action :ensure_owner_or_admin, only: [ :edit, :update, :destroy, :volunteers ]
  before_action :set_filters_open, only: :index
  before_action :set_projects_query, only: :index
  before_action :hydrate_project_categories, only: :index
  before_action :ensure_no_legacy_filtering, only: :index
  before_action :set_bg_white, only: [:index, :own, :volunteered]

  def index
    params[:page] ||= 1
    @show_filters = true
    @show_search_bar = true
    @show_sorting_options = true
    @show_global_announcements = false
    @applied_filters = params.dup

    if request.path != projects_path and params[:category_slug].present?
      @project_category = Settings.project_categories.find { |category| category.slug == params[:category_slug] }

      raise ActionController::RoutingError, 'Not Found' if @project_category.blank?

      if @project_category.present?
        @applied_filters[:project_types] = @project_category[:project_types]
        @featured_projects = Rails.cache.read "project_category_#{@project_category[:name].downcase}_featured_projects"
      end
    else
      @featured_projects = Project.get_featured_projects
    end

    respond_to do |format|
      format.html do
        @projects_header = 'COVID-19 projects looking for volunteers'
        @projects_subheader = 'New or established projects helping with the COVID-19 crisis that need help. Volunteer yourself or create a new one.'
        @page_title = 'All Projects'

        @projects = @projects.page(params[:page]).per(25)

        @index_from = (@projects.prev_page || 0) * @projects.limit_value + 1
        @index_to = [@index_from + @projects.limit_value - 1, @projects.total_count].min
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
    updated = @project.update(project_params)

    respond_to do |format|
      if updated
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
      params[:volunteer_note] ||= ''

      Volunteer.create(user: current_user, project: @project, note: params[:volunteer_note])

      ProjectMailer.with(project: @project, user: current_user, note: params[:volunteer_note]).new_volunteer.deliver_now

      flash[:notice] = 'Thanks for volunteering! The project owners will be alerted.'
      track_event 'User volunteered'
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
      params.fetch(:project, {}).permit(:name, :description, :participants, :looking_for, :contact, :volunteer_location, :target_country, :target_location, :progress, :docs_and_demo, :accepting_volunteers, :number_of_volunteers, :links, :status, :short_description, :image, :organization_status, :ein, skill_list: [], project_type_list: [])
    end

    def ensure_owner_or_admin
      if !@project.can_edit?(current_user)
        flash[:error] = "Apologies, you don't have access to this."
        redirect_to projects_path
      end
    end

    def set_projects_query
      @applied_filters = {}

      @projects = Project
      @projects = @projects.tagged_with(params[:skills], any: true, on: :skills) if params[:skills].present?
      @projects = @projects.tagged_with(params[:project_types], any: true, on: :project_types) if params[:project_types].present?
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

      if params[:project_types].present?
        @applied_filters[:project_types] = params[:project_types]
      end

      if params[:skills].present?
        @applied_filters[:skills] = params[:skills]
      end

      @projects = @projects.includes(:project_types, :skills, :volunteers)
    end

    def ensure_no_legacy_filtering
      new_params = {}

      if params[:skills].present? and params[:skills].include? ','
        new_params[:skills] = params[:skills].split(',')
      end

      if params[:project_types].present? and params[:project_types].include? ','
        new_params[:project_types] = params[:project_types].split(',')
      end

      return redirect_to projects_path(new_params) if new_params.present?
    end

    def get_order_param
      return 'created_at asc' if params[:sort_by] == 'earliest'
      return 'created_at desc' if params[:sort_by] == 'latest'
      return 'volunteers.count asc' if params[:sort_by] == 'volunteers_needed'
    end
end
