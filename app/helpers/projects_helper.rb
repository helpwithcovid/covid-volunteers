module ProjectsHelper
  def project_row_class(project)
    project_class = 'hover:bg-gray-50 focus:outline-none focus:bg-gray-50'

    project_class = 'border-2 border-orange-300 bg-orange-100' if project.highlight
  end
end
