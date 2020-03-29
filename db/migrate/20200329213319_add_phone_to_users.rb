class AddPhoneToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :phone, :string, default: ""
    add_column :users, :affiliation, :string, default: ""
    add_column :users, :resume, :string, default: ""
  end
end
