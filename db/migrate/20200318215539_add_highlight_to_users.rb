class AddHighlightToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :highlight, :boolean, null: false, default: false
  end
end
