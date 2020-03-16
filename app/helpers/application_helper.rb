module ApplicationHelper
  NAV_LINK_ACTIVE_CLASS = "inline-flex items-center px-1 pt-1 border-b-2 border-indigo-500 text-sm font-medium leading-5 text-gray-900 focus:outline-none focus:border-indigo-700 transition duration-150 ease-in-out"
  NAV_LINK_INACTIVE_CLASS = "inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm font-medium leading-5 text-gray-500 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-300 transition duration-150 ease-in-out"

  def all_projects_nav_link_class
    params[:controller] == 'projects' && params[:action] == 'index' ? NAV_LINK_ACTIVE_CLASS : NAV_LINK_INACTIVE_CLASS
  end

  def liked_projects_nav_link_class
    params[:controller] == 'projects' && params[:action] == 'liked' ? NAV_LINK_ACTIVE_CLASS : NAV_LINK_INACTIVE_CLASS
  end

  def own_projects_nav_link_class
    params[:controller] == 'projects' && params[:action] == 'own' ? NAV_LINK_ACTIVE_CLASS : NAV_LINK_INACTIVE_CLASS
  end

  def profile_nav_link_class
    params[:controller] == 'devise/registrations' ? NAV_LINK_ACTIVE_CLASS : NAV_LINK_INACTIVE_CLASS
  end

  def sign_up_nav_link_class
    params[:controller] == 'devise/registrations' ? NAV_LINK_ACTIVE_CLASS : NAV_LINK_INACTIVE_CLASS
  end

  def login_nav_link_class
    params[:controller] == 'devise/sessions' ? NAV_LINK_ACTIVE_CLASS : NAV_LINK_INACTIVE_CLASS
  end

  def logout_nav_link_class
    NAV_LINK_INACTIVE_CLASS
  end
end
