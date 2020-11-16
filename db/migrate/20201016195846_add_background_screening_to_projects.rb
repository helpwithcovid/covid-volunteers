class AddBackgroundScreeningToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :background_screening_required, :boolean
  end
end
