class AddRemoteLocationToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :remote_location, :string, default: ""
  end
end
