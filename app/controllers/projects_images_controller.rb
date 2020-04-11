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
    new_cover_photo_id = params[:id].to_i == @project.cover_photo_id ? nil : params[:id].to_i
    @project.update(cover_photo_id: new_cover_photo_id)

    respond_to do |format|
      format.html { redirect_back fallback_location: edit_project_path(@project), notice: 'Changed cover photo.' }
      format.json { render :show, location: @project }
    end
  end
end
