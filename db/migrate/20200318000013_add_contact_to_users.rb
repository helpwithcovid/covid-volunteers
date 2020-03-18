class AddContactToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :contact, :string, null: false, default: ""
  end
end
