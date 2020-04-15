# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]
  before_action :set_filters_open, only: :index

  def index
    params[:page] ||= 1

    @show_search_bar = true
    @show_sorting_options = true

    @users = User
    @users = @users.tagged_with(params[:skills]) if params[:skills].present?

    if params[:query].present?
      @users = @users.search(params[:query])
    else
      @users = @users
    end

    @users = @users.order(get_order_param) if params[:sort_by]

    @users = @users.where(visibility: true) unless current_user && current_user.is_admin?

    @users = @users.page(params[:page]).per(25)

    @index_from = (@users.prev_page || 0) * @users.current_per_page + 1
    @index_to = [@index_from + @users.current_per_page - 1, @users.total_count].min
    @total_count = @users.total_count

    @show_filters = true
  end

  def show
    @user = User.find(params[:id])

    if @user.blank?
      flash[:error] = 'Sorry, no such user.'
      redirect_to projects_path
      return
    end

    if !@user.is_visible_to_user?(current_user)
      flash[:error] = 'Sorry, no such user.'
      redirect_to projects_path
      return
    end
  end

  def new
    track_event 'User registration started'
    super
  end

  def create
    track_event 'User registration complete'
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [ :about, :profile_links, :location ])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :about, :profile_links, :location, :visibility, :pair_with_projects,  :level_of_availability, :skill_list => []])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    projects_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def update_resource(resource, params)
    if params[:password].present?
      super(resource, params)
    else
      Rails.logger.error 'here pac pac'
      params.delete(:password_confirmation)
      params.delete(:current_password)
      resource.update_without_password(params)
    end
  end

  def get_order_param
    return 'created_at desc' if params[:sort_by] == 'latest'
    return 'created_at asc' if params[:sort_by] == 'earliest'
  end
end
