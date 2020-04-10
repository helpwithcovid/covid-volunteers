class AddMainImageToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :cover_photo_id, :integer, null: true
  end
end
