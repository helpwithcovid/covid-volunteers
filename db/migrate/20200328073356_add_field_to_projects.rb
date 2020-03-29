class AddFieldToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :links, :string, null: true, default: ""
  end
end
