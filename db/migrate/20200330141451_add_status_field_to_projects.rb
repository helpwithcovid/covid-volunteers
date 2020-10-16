class AddStatusFieldToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :status, :string, { null:false, default: "" }
  end
end
