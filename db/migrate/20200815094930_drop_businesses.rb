class DropBusinesses < ActiveRecord::Migration[6.0]
  def change
  	drop_table :businesses
  end
end
