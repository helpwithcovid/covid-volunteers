class HomeController < ApplicationController
  def index
    @project_count = (Project.count / 50).floor * 50
    @volunteer_count = (User.count / 100).floor * 100
    @featured_projects = Project.take 3
    @featured_groups = @project_groups.select { |group| group[:featured] }
    @events = [
      {
        name: 'How to manage volunteers',
        body: 'Glen Moriarty, founder of 7 cups will lead a webinar on how he manages 320k volunteers.',
        date: Time.at(1000 + rand * (2000.to_f - 1000.to_f)),
        url: projects_path
      },
      {
        name: 'Funding Webinar',
        body: 'On navigating large family offices and private funding.',
        date: Time.at(1000 + rand * (2000.to_f - 1000.to_f)),
        url: projects_path
      },
      {
        name: 'Funding Webinar',
        body: 'Group office hours are 45 minutes each and include up to six other teams.',
        date: Time.at(1000 + rand * (2000.to_f - 1000.to_f)),
        url: projects_path
      },
    ]
  end
end
