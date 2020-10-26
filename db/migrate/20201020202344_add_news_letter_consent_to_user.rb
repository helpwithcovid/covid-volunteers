class AddNewsLetterConsentToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :newsletter_consent, :boolean
  end
end
