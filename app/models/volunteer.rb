class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :volunteer_abilities

  accepts_nested_attributes_for :volunteer_abilities
end
