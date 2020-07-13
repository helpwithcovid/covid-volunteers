class UserMailer < ApplicationMailer
  def office_hour_invite
    @office_hour = params[:office_hour]

    # Add .ics as an attachment.
    mail.attachments['invite.ics'] = {
      content_type: 'text/calendar; charset=UTF-8; method=REQUEST',
      mime_type:    'text/calendar;method=REQUEST',
      content:      @office_hour.to_calendar
    }

    mail(to: @office_hour.user.email, reply_to: @office_hour.user.email, cc: @office_hour.participant.email, subject: I18n.t('office_hour_slot_booked'))
  end

  def office_hour_application
    @office_hour = params[:office_hour]
    @application = params[:application]

    mail(to: @office_hour.user.email, subject: I18n.t('new_office_hour_application'))
  end
end
