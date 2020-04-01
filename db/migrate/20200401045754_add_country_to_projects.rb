class AddCountryToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :country, :string, null: false, default: ""
  end
end
