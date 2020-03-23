module RegistrationsHelper
  def sortable(title, column, direction)
    direction = sort_direction == "asc" ? "desc" : "asc"
    icon = sort_direction == 'desc' ? 'down' : 'up'
    path = volunteers_path + "?sort=#{column}&direction=#{direction}"

    link_to path, class: "button small black", id: column do
      "#{title} &nbsp; <i class=fi-arrow-#{icon}></i>".html_safe
    end
  end
end
