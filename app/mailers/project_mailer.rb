class ProjectMailer < ApplicationMailer
  def new_volunteer
    @project = params[:project]
    @user = params[:user]
    @note = params[:note]
    @user_volunteered_projects_count = @user.volunteers.count

    mail(to: @project.user.email, reply_to: @user.email, subject: I18n.t('you_got_a_new_volunteer_for_name', name: @project.name))
  end
end
