class ProjectsImagesController < ApplicationController
  def destroy
    @project = Project.find params[:project_id]
    @image = @project.images.find params[:id]
    @project.update(cover_photo_id: nil) if @project.cover_photo_id == params[:id].to_i
    @image.purge

    respond_to do |format|
      format.html { redirect_back fallback_location: edit_project_path(@project), notice: 'Image destroyed.' }
      format.json { render :show, location: @project }
    end
  end

  def set_cover_photo
    @project = Project.find params[:project_id]
    @project.update(cover_photo_id: params[:id])

    respond_to do |format|
      format.html { redirect_back fallback_location: edit_project_path(@project), notice: 'Main image set.' }
      format.json { render :show, location: @project }
    end
  end
end
