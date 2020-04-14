class ProjectCategoriesController < ApplicationController
  def show
    @show_global_announcements = false
    @project_category = Settings.project_categories.find { |category| category.slug == params[:slug] }

    raise ActionController::RoutingError, 'Not Found' if @project_category.blank?

    # project_types: category[:project_types].join(','), any: true
    respond_to do |format|
      format.html { render :show }
    end
  end

  private
    def set_bg_color
      @bg_color = 'white'
    end
end
