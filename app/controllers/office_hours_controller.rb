class OfficeHoursController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create, :destroy, :apply, :accept ]
  before_action :set_office_hour, only: [ :destroy, :apply, :accept ]
  before_action :ensure_owner_or_admin, only: [ :destroy, :accept ]

  before_action :set_filters_open, only: :index
  before_action :set_bg_white, only: :index

  def index
    users_filtering 'office_hours'
  end

  def new
    @office_hour = OfficeHour.new
    @confirmed_office_hours = current_user.future_office_hours.where.not(participant_id: nil)
    @unconfirmed_office_hours = current_user.future_office_hours.where(participant_id: nil)
  end

  def create
    current_user.office_hour_description = params.require(:description)
    current_user.save

    office_hour_dates = params.require(:office_hour_dates)
    office_hour_dates = office_hour_dates.values if office_hour_dates.keys.first == '0'

    added_office_hours = 0
    office_hour_dates.each_slice(2) do |date|
      office_hour = OfficeHour.new
      office_hour.start_at = DateTime.parse date[0]
      office_hour.end_at = DateTime.parse date[1]
      office_hour.user = current_user
      office_hour.save

      added_office_hours += 1
    end

    redirect_to office_hours_path, notice: I18n.t('added_office_hours_office_hours_added', added_office_hours: added_office_hours)
  end

  def destroy
    @office_hour.destroy
    redirect_to new_office_hour_path, notice: I18n.t('office_hour_was_successfully_deleted')
  end

  def apply
    if !@office_hour.application_user_ids.include?(current_user.id)
      @office_hour.application_user_ids << current_user.id
      @office_hour.save

      UserMailer.with(office_hour: @office_hour, application: current_user).office_hour_application.deliver_now
    end

    redirect_to office_hours_path, notice: I18n.t('you_application_was_sent')
  end

  def accept
    @office_hour.participant = User.find(params[:accepted_user_id])
    @office_hour.save

    UserMailer.with(office_hour: @office_hour).office_hour_invite.deliver_now

    redirect_to new_office_hour_path, notice: I18n.t('application_accepted_invite_being_sent')
  end

  protected

  def set_office_hour
    @office_hour = OfficeHour.find(params[:id])
  end

  def ensure_owner_or_admin
    if !@office_hour.can_edit?(current_user)
      flash[:error] = I18n.t('apologies_you_don_t_have_access_to_this')
      redirect_to office_hours_path
    end
  end

  def get_order_param
    return 'created_at desc' if params[:sort_by] == 'latest'
    return 'created_at asc' if params[:sort_by] == 'earliest'
  end

end
