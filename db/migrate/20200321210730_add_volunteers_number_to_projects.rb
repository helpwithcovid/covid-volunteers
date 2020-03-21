class AddVolunteersNumberToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :number_of_volunteers, :string, null: false, default: ""
  end
end
