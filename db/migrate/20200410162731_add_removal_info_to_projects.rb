class AddRemovalInfoToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :visible, :boolean, default: true
    add_column :projects, :was_helpful, :boolean, default: true
    add_column :projects, :exit_comments, :string, default: ""
  end
end
