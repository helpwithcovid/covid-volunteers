class AddUserToBusinesses < ActiveRecord::Migration[6.0]
  def change
    add_reference :businesses, :user, null: false, foreign_key: true
  end
end
