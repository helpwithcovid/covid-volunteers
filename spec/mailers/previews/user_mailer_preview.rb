# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def office_hour_invite
    office_hour = OfficeHour.where.not(participant_id: nil).last

    UserMailer.with(office_hour: office_hour).office_hour_invite
  end

  def office_hour_application
    office_hour = OfficeHour.where.not(application_user_ids: nil).last

    UserMailer.with(office_hour: office_hour, application: office_hour.applications[0]).office_hour_application
  end

end
