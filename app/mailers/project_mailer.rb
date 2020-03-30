class ProjectMailer < ApplicationMailer
  def new_volunteer
    @project = params[:project]
    @user = params[:user]

    mail(to: @project.user.email, subject: "You got a new volunteer for #{@project.name}!")
  end

  def volunteer_outreach
    @user = params[:user]
    mail(to: @user.email, reply_to: ENV['EMAIL_ADDRESS'], subject: "[Help With Covid - action required] Thank you and an update")
  end
end
