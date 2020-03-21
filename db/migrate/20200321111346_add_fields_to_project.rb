class AddFieldsToProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :number_of_volunteers_needed, :integer
  end
end
