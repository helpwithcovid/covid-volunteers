module OfficeHoursHelper
  def office_hour_button_color(oh)
    if current_user && oh.participant == current_user
      'border border-green-300 text-xs leading-4 font-medium rounded text-gray-700 bg-green-300 hover:text-green-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-green-800 active:bg-gray-50'
    elsif office_hour_slot_inactive(oh)
      'border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-gray-300 hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50'
    else
      'border border-gray-300 text-xs leading-4 font-medium rounded text-gray-700 bg-white hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50'
    end
  end

  def office_hour_slot_inactive(oh)
    return false if oh.user == current_user
    !!((current_user && oh.applied?(current_user)) || oh.participant_id.present?)
  end

  def oh_badge_color(oh)
    if oh.participant.present?
      'bg-green-200 text-green-800'
    elsif oh.applications.present?
      'bg-red-200 text-red-800'
    else
      'bg-gray-200 text-gray-800'
    end
  end

  def oh_can_apply
    !!(current_user && current_user.has_complete_profile?)
  end
end
