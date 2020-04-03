class ProjectsImagesController < ApplicationController
  def destroy
    @project = Project.find params[:project_id]
    @image = @project.images.find params[:id]
    @image.purge

    respond_to do |format|
      format.html { redirect_back fallback_location: edit_project_path(@project), notice: 'Image destroyed.' }
      format.json { render :show, location: @project }
    end
  end
end
