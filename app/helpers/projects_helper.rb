module ProjectsHelper
  def project_row_class(project)
    if project.highlight
      'hover:bg-gray-50 focus:outline-none focus:bg-gray-50'
    else
      'border-2 border-orange-300 bg-orange-100'
    end
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

  def get_country_fields
    [ 'Global' ].concat(IsoCountryCodes.for_select)
  end
end
