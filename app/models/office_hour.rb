class OfficeHour < ApplicationRecord
  belongs_to :user
  belongs_to :participant, foreign_key: 'participant_id', class_name: 'User', optional: true
end
