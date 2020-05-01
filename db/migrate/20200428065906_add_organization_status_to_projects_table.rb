class AddOrganizationStatusToProjectsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :organization_status, :string, { default: '', null: false }
  end
end
