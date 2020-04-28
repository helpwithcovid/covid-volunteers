module ProjectsHelper
  def project_row_class(project)
    if project.highlight
      'border-2 border-orange-300 bg-orange-100'
    else
      'hover:bg-gray-50 focus:outline-none focus:bg-gray-50'
    end
  end

  def is_projects_path
    request.path == projects_path or request.path.include?('/projects/p') or Settings.project_categories.map(&:slug).include?(params[:category_slug])
  end

  def format_country(country)
    return country if country == '' || country == 'Global'

    begin
      IsoCountryCodes.find(country).name
    rescue
      # Fallback to raw value
      country
    end
  end

  def project_panel_item(title: '', &block)
    render layout: 'partials/project-panel-item', locals: {title: title} do
      capture(&block)
    end
  end
end
