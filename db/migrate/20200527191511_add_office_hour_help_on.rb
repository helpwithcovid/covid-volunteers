class AddOfficeHourHelpOn < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :office_hour_description, :text
  end
end
