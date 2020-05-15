class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :show_global_announcements
  before_action :set_bg_gray

  def ensure_admin
    redirect_to projects_path if !current_user || !current_user.is_admin?
  end

  def set_filters_open
    @filters_open = case cookies['filters_open']
                    when 'nil'
                    when true
                    when 'true'
                      true
                    when false
                    when 'false'
                      false
                    else
                      true
    end
  end

  def hide_global_announcements
    @show_global_announcements = false
  end

  def show_global_announcements
    @show_global_announcements = true
  end

  def set_bg_gray
    @bg_color = 'bg-gray-100'
  end

  def set_bg_white
    @bg_color = 'bg-white'
  end

  def users_filtering(scope)
    params[:page] ||= 1

    @show_search_bar = true
    @show_sorting_options = true

    @users = User
    @users = @users.tagged_with(params[:skills], any: true, on: :skills) if params[:skills].present?

    @applied_filters = {}

    if params[:skills].present?
      @applied_filters[:skills] = params[:skills]
    end

    if params[:query].present?
      @users = @users.search(params[:query])
    else
      @users = @users
    end

    if scope == 'office_hours'
      users_with_office_hours = OfficeHour.where('start_at > ?', DateTime.now).select(:user_id).group(:user_id).all.collect { |oh| oh.user_id }.compact.uniq
      @users = @users.where(id: users_with_office_hours)

      @users = @users.where(id: params[:id]) if params[:id].present?
      # Make sure the owner's card is always first.
      @users = @users.order("
        CASE
          WHEN id = '#{current_user.id}' THEN '1'
        END") if current_user

      @show_filters = true unless params[:id]
    else
      @users = @users.where(visibility: true) unless current_user && current_user.is_admin?

      @show_filters = true
    end

    @users = @users.order(get_order_param) if params[:sort_by]

    @users = @users.includes(:skills).page(params[:page]).per(24)

    @index_from = (@users.prev_page || 0) * @users.current_per_page + 1
    @index_to = [@index_from + @users.current_per_page - 1, @users.total_count].min
    @total_count = @users.total_count
  end

  private
    def hydrate_project_categories
      @project_categories = Settings.project_categories

      exclude_ids = []
      @project_categories.each do |category|
        exclude_ids.flatten!
        category[:featured_projects] = Rails.cache.fetch("project_category_#{category[:name].downcase}_featured_projects", expires_in: 1.hour) { Project.where(highlight: true).includes(:project_types, :skills, :volunteers).where.not(id: exclude_ids).tagged_with(category[:project_types], any: true, on: :project_types).limit(3).order('RANDOM()') }
        exclude_ids << category[:featured_projects].map(&:id)
        category[:projects_count] = Rails.cache.fetch("project_category_#{category[:name].downcase}_projects_count", expires_in: 1.hour) { Project.tagged_with(category[:project_types], any: true, on: :project_types).count }
      end
    end

    def track_event(event_name)
      session[:track_event] = event_name
    end
end
