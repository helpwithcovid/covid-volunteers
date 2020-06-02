class ProjectMailer < ApplicationMailer
  def new_volunteer
    @project = params[:project]
    @user = params[:user]

    mail(to: @project.user.email, bcc: ADMINS, subject: "You got a new volunteer for #{@project.name}!")
  end

  def new_project
    @project = params[:project]
    mail(to: @project.user.email, bcc: ADMINS, subject: "You created a new position: #{@project.name}!")
  end

  def volunteer_outreach
    @user = params[:user]
    mail(to: @user.email, reply_to: HWC_EMAIL, subject: "[Help With Covid <%= CITY_NAME %> - action required] Thank you and an update")
  end
end
