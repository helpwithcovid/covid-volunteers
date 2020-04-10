class CreateVolunteerAbilities < ActiveRecord::Migration[6.0]
  def change
    create_table :volunteer_abilities do |t|
      t.belongs_to :volunteer, foreign_key: true
      t.string :permission
      t.boolean :enabled, default: false
    end
  end
end
