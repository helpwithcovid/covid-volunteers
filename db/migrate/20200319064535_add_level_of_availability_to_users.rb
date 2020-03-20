class AddLevelOfAvailabilityToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :level_of_availability, :string
  end
end
