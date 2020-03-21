class AddProgressToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :progress, :string, null: false, default: ""
    add_column :projects, :docs_and_demo, :string, null: false, default: ""
  end
end
