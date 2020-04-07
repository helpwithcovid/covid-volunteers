class AddNoteToVolunteers < ActiveRecord::Migration[6.0]
  def change
    add_column :volunteers, :note, :string, { null: false, default: '' }
  end
end
