module ApplicationHelper
  def nav_link_active_class(variant = 'DESKTOP')
    case variant
    when 'DESKTOP'
      'inline-flex items-center px-1 pt-1 border-b-2 border-indigo-500 text-sm font-medium leading-5 text-gray-900 focus:outline-none focus:border-indigo-700 transition duration-150 ease-in-out mr-8 text-center'
    when 'MOBILE'
      'block pl-3 pr-4 py-2 border-l-4 border-indigo-500 text-base font-medium text-indigo-700 bg-indigo-50 focus:outline-none focus:text-indigo-800 focus:bg-indigo-100 focus:border-indigo-700 transition duration-150 ease-in-out'
    end
  end

  def nav_link_inactive_class(variant = 'DESKTOP')
    case variant
    when 'DESKTOP'
      'inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium leading-5 text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-300 transition duration-150 ease-in-out mr-8 text-center'
    when 'MOBILE'
      'mt-1 block pl-3 pr-4 py-2 border-l-4 border-transparent text-base font-medium text-gray-600 hover:text-gray-800 hover:bg-gray-50 hover:border-gray-300 focus:outline-none focus:text-gray-800 focus:bg-gray-50 focus:border-gray-300 transition duration-150 ease-in-out'
    end
  end

  def all_projects_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'projects' && params[:action] == 'index' ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def volunteered_projects_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'projects' && params[:action] == 'volunteered' ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def own_projects_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'projects' && params[:action] == 'own' ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def profile_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'users/registrations' && [ 'edit', 'update' ].include?(params[:action]) ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def sign_up_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'devise/registrations' ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def login_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'devise/sessions' ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def volunteers_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'users/registrations' && [ 'index' ].include?(params[:action]) ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def offers_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'offers' && [ 'index' ].include?(params[:action]) ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def logout_nav_link_class(variant = 'DESKTOP')
    nav_link_inactive_class(variant)
  end

  def alert_container_class_for_flash_type type
    base_class = 'border px-4 py-3 rounded relative'

    Rails.logger.error type
    if [ 'alert', 'error'].include?(type)
      base_class += ' bg-red-100 border-red-400 text-red-700'
    elsif type == 'notice'
      base_class += ' bg-green-100 border-green-400 text-green-700'
    else
      base_class += ' bg-orange-100 border-orange-400 text-orange-700'
    end

    base_class
  end
end
