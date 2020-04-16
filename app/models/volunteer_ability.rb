class VolunteerAbility < ActiveRecord::Base
  belongs_to :volunteer

  enum permission: {
    receive_volunteer_notifications: "receive_volunteer_notifications"
  }

  PERMISSION_LABELS = {
    "receive_volunteer_notifications" => "Receives volunteer notification emails"
  }

  validates :permission, inclusion: { in: VolunteerAbility.permissions.keys }
end