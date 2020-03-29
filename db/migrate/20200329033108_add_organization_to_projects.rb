class AddOrganizationToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :organization, :string, default: ""
    add_column :projects, :level_of_urgency, :string, null: false, default: ""
    add_column :projects, :start_date, :string, default: ""
    add_column :projects, :end_date, :string, default: ""
    add_column :projects, :compensation, :string, default: ""
  end
end
