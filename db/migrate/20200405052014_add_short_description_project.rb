class AddShortDescriptionProject < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :short_description, :string, { default: '', null: false}
  end
end
