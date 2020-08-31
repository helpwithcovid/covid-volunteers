class AddNeedsFundingToProjects < ActiveRecord::Migration[6.0]
  def change
  	add_column :projects, :needs_funding, :boolean, default: false, null: false
  end
end
