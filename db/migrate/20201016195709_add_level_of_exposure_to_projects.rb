class AddLevelOfExposureToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :level_of_exposure, :string
  end
end
