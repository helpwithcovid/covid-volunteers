class AddFieldsToProjectOwners < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :progress, :string

  end
end
