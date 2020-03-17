class ProjectMailer < ApplicationMailer
  def new_volunteer
    @project = params[:project]
    @user = params[:user]

    mail(to: @project.user.email, subject: "You got a new volunteer for #{@project.name}!")
  end
end
