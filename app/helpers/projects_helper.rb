module ProjectsHelper
  def project_row_class(project)
    project_class = 'hover:bg-gray-50 focus:outline-none focus:bg-gray-50'

    project_class = 'border-2 border-orange-300 bg-orange-100' if project.highlight
  end

  def projects_sortable(title, column, direction)
    direction = sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == 'desc' ? 'down' : 'up'
    path = projects_path + "?sort=#{column}&direction=#{direction}"

    link_to path, class: "button small black", id: column do
      "#{title} &nbsp; <i class=fi-arrow-#{icon}></i>".html_safe
    end
  end
end
