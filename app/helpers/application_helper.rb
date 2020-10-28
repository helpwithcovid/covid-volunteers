module ApplicationHelper
  def section_name(name = '')
    "<div class='text-lg font-bold'>#{name}</div>".html_safe
  end

  def nav_link_active_class(variant = 'DESKTOP')
    case variant
    when 'DESKTOP'
      'inline-flex items-center px-1 pt-1 border-b-2 border-primary-600 text-sm leading-5 text-gray-900 focus:outline-none focus:border-primary-700 transition duration-150 ease-in-out ml-4 text-center font-bold'
    when 'MOBILE'
      'mt-1 block pl-3 pr-4 py-2 border-l-4 border-primary-600 text-base text-primary-700 bg-primary-50 focus:outline-none focus:text-primary-800 focus:bg-primary-100 focus:border-primary-700 transition duration-150 ease-in-out'
    end
  end

  def nav_link_inactive_class(variant = 'DESKTOP')
    case variant
    when 'DESKTOP'
      'inline-flex items-center px-1 pt-1 border-b-2 border-transparent text-sm leading-5 text-gray-600 hover:text-gray-700 hover:border-gray-300 focus:outline-none focus:text-gray-700 focus:border-gray-300 transition duration-150 ease-in-out ml-4 text-center'
    when 'MOBILE'
      'mt-1 block pl-3 pr-4 py-2 border-l-4 border-transparent text-base text-gray-600 hover:text-gray-800 hover:bg-gray-50 hover:border-gray-300 focus:outline-none focus:text-gray-800 focus:bg-gray-50 focus:border-gray-300 transition duration-150 ease-in-out'
    end
  end

  def sub_nav_link_inactive_class(variant = 'DESKTOP')
    case variant
    when 'DESKTOP'
      'flex-inline text-gray-600 border-b-2 border-transparent hover:border-gray-300'
    when 'MOBILE'
      'mt-1 block pl-3 pr-4 py-2 border-l-4 border-transparent text-base text-gray-600 hover:text-gray-800 hover:bg-gray-50 hover:border-gray-300 focus:outline-none focus:text-gray-800 focus:bg-gray-50 focus:border-gray-300 transition duration-150 ease-in-out'
    end
  end

  def sub_nav_link_active_class(variant = 'DESKTOP')
    case variant
    when 'DESKTOP'
      'flex-inline text-gray-600 border-b-2 border-transparent text-primary-600 font-bold'
    when 'MOBILE'
      'mt-1 block pl-3 pr-4 py-2 border-l-4 border-primary-600 text-base text-primary-700 bg-primary-50 focus:outline-none focus:text-primary-800 focus:bg-primary-100 focus:border-primary-700 transition duration-150 ease-in-out'
    end
  end

  def all_projects_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'projects' && params[:action] == 'index' ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def volunteered_projects_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'projects' && params[:action] == 'volunteered' ? sub_nav_link_active_class(variant) : sub_nav_link_inactive_class(variant)
  end

  def own_projects_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'projects' && params[:action] == 'own' ? sub_nav_link_active_class(variant) : sub_nav_link_inactive_class(variant)
  end

  def profile_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'users/registrations' && [ 'edit', 'update' ].include?(params[:action]) ? sub_nav_link_active_class(variant) : sub_nav_link_inactive_class(variant)
  end

  def sign_up_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'users/registrations' && [ 'new' ].include?(params[:action]) ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
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

  def office_hours_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'office_hours' && [ 'index' ].include?(params[:action]) ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def success_stories_nav_link_class(variant = 'DESKTOP')
    params[:controller] == 'success_stories' && [ 'index' ].include?(params[:action]) ? nav_link_active_class(variant) : nav_link_inactive_class(variant)
  end

  def logout_nav_link_class(variant = 'DESKTOP')
    sub_nav_link_inactive_class(variant)
  end

  def discord_nav_link_class(variant = 'DESKTOP')
    nav_link_inactive_class(variant)
  end

  def alert_container_class_for_flash_type(type)
    base_class = 'border px-4 py-3 rounded relative'

    if [ 'alert', 'error'].include?(type)
      base_class += ' bg-red-100 border-red-400 text-red-700'
    elsif type == 'notice'
      base_class += ' bg-green-100 border-green-400 text-green-700'
    else
      base_class += ' bg-orange-100 border-orange-400 text-orange-700'
    end

    base_class
  end

  def filter_badge(label: nil, model: nil, filter_by: nil, color: 'primary', title: nil, value: nil)
    if model.present?
      query_string = build_query_string(toggle_filter(filter_by, value || label))
      url = "/#{model}"
      url << "?#{query_string}" if query_string.present?
    end

    applied = get_query_params[filter_by].include?(label)

    if filter_by == 'project_types' and @applied_project_types.present? and @applied_project_types.include?(label)
      applied = true
    end

    case color
    when 'blue'
      classes = 'bg-blue-100 text-blue-800'
      classes += ' bg-blue-300' if applied
    when 'secondary'
      classes = 'bg-secondary-100 text-secondary-800'
      classes += ' bg-secondary-300' if applied
    when 'orange'
      classes = 'bg-orange-100 text-orange-800'
      classes += ' bg-orange-300' if applied
    when 'red'
      classes = 'bg-gray-100 text-red-800'
      classes += 'bg-gray-300' if applied
    else
      classes = 'bg-gray-100 text-black-800'
      classes += ' bg-primary-300' if applied
    end

    render partial: 'partials/filter-badge', locals: {label: label, url: url, classes: classes, title: title, color: color}
  end

  def clear_filter_badge(label: nil, model: nil, filter_by: nil, color: nil, title: nil)
    query_string = build_query_string(get_query_params.filter { |k, _| k!= filter_by })
    url = "/#{model}"
    url << "?#{query_string}" if query_string.present?

    classes = 'bg-gray-100 text-gray-800'
    classes += ' bg-gray-200' if get_query_params[filter_by].length == 0

    render partial: 'partials/filter-badge', locals: {label: label, url: url, classes: classes, title: title, color: 'gray'}
  end

  def get_query_params
    # return a Params-like hash that only has query params, and returns an empty array when accessing a nonexistent key
    query_params = Hash.new(Array.new)
    return query_params if not URI.parse(request.fullpath).query
    CGI.parse(URI.parse(request.fullpath).query).reduce(query_params) do |acc, el|
      return acc if el[1][0].blank?

      acc[el[0]] = el[1][0].split(',')
      acc
    end
  end

  def toggle_filter(filter_key, filter)
    query_params = get_query_params
    filters = get_query_params[filter_key]
    toggled = filters.include?(filter) ? filters.filter { |el| el != filter } : filters + [filter]
    query_params[filter_key] = toggled
    query_params
  end

  def build_query_string(query_params)
    params_array = query_params.map do |k, v|
      next if v.length == 0
      value = v.map { |s| CGI.escape s }.join(',')
      "#{k}[]=#{value}"
    end
    params_array.reject(&:nil?).join('&')
  end

  def skill_badges(items, limit: nil, color: 'primary', title: '', model: '', filter_by: '')
    limit ||= items.count

    render partial: 'partials/skill_badges', locals: { color: 'primary', items: items, limit: limit, title: title, model: model, filter_by: filter_by }
  end

  def sort_drop_down(&block)
    render layout: 'partials/sort-drop-down' do
      capture(&block)
    end
  end

  def sort_drop_down_option(path, title, sort_by = nil)
    new_params = params.permit(:sort_by, :skills, :project_types).dup

    case params[:sort_by]
    when sort_by
      new_params.delete :sort_by
      active = true
    else
      new_params[:sort_by] = sort_by
    end

    if sort_by.nil?
      new_params.delete :sort_by
    end

    path = path + "?#{new_params.to_query}" if new_params.present?

    "<option value='#{path}' #{'selected' if active}>#{title}</option>".html_safe
  end

  def filter_bar_filter(label, filter, options)
    render partial: 'projects/filter-bar-filter', locals: {options: options, label: label, filter: filter.to_s}
  end

  def google_analytics_id
    #Rails.env.production? ? 'UA-162054776-1' : 'UA-162054776-2'
  end

  def track_ga_event_if_needed
    event = session.delete(:track_event)
    return '' if event.blank?

    "gtag('event', '#{event}', {'event_category': 'Actions'});".html_safe
  end

  def list_cards(&block)
    "<div class='w-full px-4 sm:px-0 space-y-bottom-4 sm:grid grid-cols-2 lg:grid-cols-3 sm:gap-6 grid-auto-row-1fr'>#{capture(&block)}</div>".html_safe
  end

  def url_from_string(string)
    string_with_links = Rinku.auto_link(sanitize(string))
    URI.parse(string_with_links[URI.regexp(%w(http https mailto))]) rescue nil
  end

  def shorten_url(url)
    return nil if url.nil?
    url.scheme == 'mailto' ? url.opaque : url.host
  end

  def enabled_features
    Settings.features_enabled.to_hash.map{|k,v| k.to_s if v == true }
  end

  def feature_enabled?(feature)
    enabled_features.include? feature
  end
end
