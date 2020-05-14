class AddApplicantsToOfficeHours < ActiveRecord::Migration[6.0]
  def change
    add_column :office_hours, :application_user_ids, :integer, array: true, null: false, default: []
  end
end
