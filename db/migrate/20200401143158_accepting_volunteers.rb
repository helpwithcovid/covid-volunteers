class AcceptingVolunteers < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :accepting_volunteers, :boolean, default: true
  end
end
