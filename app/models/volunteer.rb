class Volunteer < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :abilities, class_name: "VolunteerAbility"

  accepts_nested_attributes_for :abilities

  scope :with_ability, -> (a) { joins(:abilities).where(volunteer_abilities: {permission: a}) }
end
