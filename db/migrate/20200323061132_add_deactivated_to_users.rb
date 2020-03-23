class AddDeactivatedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :deactivated, :boolean, null: false, default: false
  end
end
