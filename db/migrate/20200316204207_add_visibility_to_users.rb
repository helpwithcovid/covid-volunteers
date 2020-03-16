class AddVisibilityToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :visibility, :boolean, default: false
  end
end
