class CreateVolunteerGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteer_groups do |t|
      t.integer :project_id
      t.integer :assigned_user_ids, array: true, null: false, default: []
      t.timestamps
    end
  end
end
