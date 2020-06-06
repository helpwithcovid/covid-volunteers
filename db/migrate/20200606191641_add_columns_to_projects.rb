class AddColumnsToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :organization_mission, :string
    add_column :projects, :organization_registered, :boolean
  end
end
