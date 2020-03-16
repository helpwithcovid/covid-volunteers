class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :name, null: false, default: ""
      t.string :description, null: false, default: ""
      t.string :participants, null: false, default: ""
      t.string :looking_for, null: false, default: ""
      t.timestamps
    end
  end
end
