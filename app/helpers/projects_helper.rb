module ProjectsHelper
  def project_row_class(project)
    if project.highlight
      'border-2 border-orange-300 bg-orange-100'
    else
      'hover:bg-gray-50 focus:outline-none focus:bg-gray-50'
    end
  end

  def is_category_path
    request.path == projects_path || Settings.project_categories.map(&:slug).include?(request.path.sub('/', ''))
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
end
