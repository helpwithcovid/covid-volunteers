module OfficeHoursHelper
  def oh_owner_action_color(oh)
    if oh.participant.present?
      'bg-green-200 text-gray-700'
    elsif oh.applications.present?
      'bg-orange-200 text-gray-700'
    else
      'bg-gray-200 text-gray-700'
    end
  end

  def office_hour_slot_inactive(oh)
    !!((current_user && oh.applied?(current_user)) || oh.participant_id.present?)
  end

  def oh_can_apply
    !!(current_user && current_user.has_complete_profile?)
  end
end
