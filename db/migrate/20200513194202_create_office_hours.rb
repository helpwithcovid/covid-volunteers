class CreateOfficeHours < ActiveRecord::Migration[6.0]
  def change
    create_table :office_hours do |t|
      t.integer :user_id, null: false
      t.integer :participant_id
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.timestamps
    end
  end
end
