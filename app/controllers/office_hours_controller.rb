class OfficeHoursController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  before_action :set_filters_open, only: :index
  before_action :set_bg_white, only: :index

  def index
    users_filtering 'office_hours'
  end

  def new
    @office_hour = OfficeHour.new
  end

  def create

    office_hour_dates = params.require(:office_hour_dates)
    office_hour_dates = office_hour_dates.values if office_hour_dates.keys.first == '0'

    Rails.logger.error office_hour_dates

    added_office_hours = 0
    office_hour_dates.each_slice(2) do |date|
      Rails.logger.error date
      office_hour = OfficeHour.new
      office_hour.start_at = DateTime.parse date[0]
      office_hour.end_at = DateTime.parse date[1]
      office_hour.user = current_user
      Rails.logger.error office_hour.inspect
      office_hour.save

      Rails.logger.error office_hour.errors.inspect
      added_office_hours += 1
    end

    redirect_to edit_user_registration_path, notice: "#{added_office_hours} office hours added."
  end

end
