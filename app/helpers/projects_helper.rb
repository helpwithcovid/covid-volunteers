module ProjectsHelper
  def project_row_class(project)
    project_class = 'hover:bg-gray-50 focus:outline-none focus:bg-gray-50'

    project_class = 'border-2 border-orange-300 bg-orange-100' if project.highlight
  end

  def format_country(country)
    return country if (country == '' || country == 'Global')

    begin
      return IsoCountryCodes.find(country).name
    rescue
      # Fallback to raw value
      return country
    end
  end

  def get_country_fields()
    return ['Global'].concat(IsoCountryCodes.for_select)
  end
end
