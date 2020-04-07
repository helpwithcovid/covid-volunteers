# Preview all emails at http://localhost:3000/rails/mailers/project_mailer
class ProjectMailerPreview < ActionMailer::Preview
  def new_volunteer
    user = User.first
    project = Project.last

    ProjectMailer.with(project: project, user: user, note: 'Note from volunteer').new_volunteer
  end

  def volunter_outreach
    user = User.first
    ProjectMailer.with(user: user).volunteer_outreach
  end
end
