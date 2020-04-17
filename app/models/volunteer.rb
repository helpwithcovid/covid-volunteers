class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :volunteer_abilities

  accepts_nested_attributes_for :volunteer_abilities

  scope :with_ability, -> (a) { joins(:volunteer_abilities).where(volunteer_abilities: {permission: a}) }
end
