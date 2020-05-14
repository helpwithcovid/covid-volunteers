class ImagesController < ApplicationController
  def destroy
    return nil unless ['success_stories', 'projects'].include? params[:resource_name]

    @resource = params[:resource_name].singularize.titleize.safe_constantize.find params[:resource_id]
    @resource.image.purge
    @resource.save

    respond_to do |format|
      format.html { redirect_back fallback_location: root_path, notice: 'Image removed.' }
      format.json { render :show, location: @resource }
    end
  end
end
