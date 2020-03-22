class AddPairUsersField < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :pair_with_projects, :boolean, default:false
  end
end
