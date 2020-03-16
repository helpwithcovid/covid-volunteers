class AddMoreFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :about, :string, null: false, default: ""
    add_column :users, :location, :string, null: false, default: ""
    add_column :users, :profile_links, :string, null: false, default: ""
  end
end
