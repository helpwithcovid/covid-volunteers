class AddAgeConsentToUsers < ActiveRecord::Migration[6.0]
  def change
  	add_column :users, :age_consent, :boolean, default: false
  end
end
