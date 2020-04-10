class UpdateAddLocationFieldsForProjects < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :location, :volunteer_location
    add_column :projects, :target_country, :string, null: false, default: ""
    add_column :projects, :target_location, :string, null: false, default: ""
  end
end
