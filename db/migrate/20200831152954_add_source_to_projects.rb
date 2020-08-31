class AddSourceToProjects < ActiveRecord::Migration[6.0]
  def change
  	add_column :projects, :source, :string, null: true
  end
end
