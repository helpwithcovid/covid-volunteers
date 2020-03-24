# frozen_string_literal: true
module RegistrationsHelper
  def volunteers_sortable_select(title, column, direction)
    direction = volunteers_sort_direction == 'ASC' ? 'DESC' : 'ASC'
    icon = volunteers_sort_direction == 'DESC' ? 'down' : 'up'
    path = volunteers_path + "?sort=#{column}&direction=#{direction}"

    link_to path, class: 'button small black', id: column do
      "#{title} &nbsp; <i class=media/svgs/drop-#{icon}-arrow.svg></i>".html_safe
    end
  end

  def volunteers_sort_direction
    %w[ASC DESC].include?(params[:direction]) ? params[:direction] : 'ASC'
  end
end
