class DataController < ApplicationController
  def projects
    respond_with_csv(Project, Project.column_names)
  end

  def users
    respond_with_csv(User, ["id", 
    "created_at", "updated_at", "location", 
    "level_of_availability", "pair_with_projects", "affiliation"])
  end

  def volunteers
    respond_with_csv(Volunteer, Volunteer.column_names)
  end

  private

  def respond_with_csv(model, fields)
    data = CSV.generate(headers: true) do |csv|
      csv << fields

      model.all.each do |e|
        csv << e.attributes
      end
    end

    respond_to do |format|
      format.csv { send_data data }
    end
  end
end
