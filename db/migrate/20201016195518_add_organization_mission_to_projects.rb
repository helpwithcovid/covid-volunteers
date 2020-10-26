class AddOrganizationMissionToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :organization_mission, :string
    add_column :projects, :organization_registered, :boolean
    add_column :projects, :end_date_recurring, :boolean
  end
end
