class VolunteerAbility < ActiveRecord::Base
  belongs_to :volunteer

  enum permission: {
    receive_volunteer_notifications: "receive_volunteer_notifications"
  }

  validates :permission, inclusion: { in: VolunteerAbility.permissions.keys }
end