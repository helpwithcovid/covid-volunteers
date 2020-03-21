module ProjectsHelper
  def project_row_class(project)
    project_class = 'hover:bg-gray-50 focus:outline-none focus:bg-gray-50'

    project_class = 'border-2 border-orange-300 bg-orange-100' if project.highlight
  end

  def badges_for_project_types(project)
    to_display = 3

    if project.project_type_list.count > to_display
      extra = project.project_type_list.dup.drop(to_display).count
    end

    render partial: 'badges_for_project_types', locals: {project_types: project.project_type_list.take(to_display), extra: extra}
  end
end
