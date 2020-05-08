class SuccessStoriesController < ApplicationController
  before_action :set_success_story, only: [:show, :edit, :update, :destroy]
  before_action :set_bg_white

  # GET /success_stories
  # GET /success_stories.json
  def index
    @page_title = 'Success Stories'
    @success_stories = SuccessStory.all
  end

  # GET /success_stories/1
  # GET /success_stories/1.json
  def show
  end

  # GET /success_stories/new
  def new
    unless current_user.is_admin?
      flash[:message] = 'You have to be an admin to add stories.'

      return redirect_to success_stories_path
    end

    @success_story = SuccessStory.new
  end

  # GET /success_stories/1/edit
  def edit
    unless current_user.is_admin?
      flash[:message] = 'You have to be an admin to add stories.'

      return redirect_to success_stories_path
    end
  end

  # POST /success_stories
  # POST /success_stories.json
  def create
    @success_story = SuccessStory.new(success_story_params)

    respond_to do |format|
      if @success_story.save
        format.html { redirect_to @success_story, notice: 'Success story was successfully created.' }
        format.json { render :show, status: :created, location: @success_story }
      else
        format.html { render :new }
        format.json { render json: @success_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /success_stories/1
  # PATCH/PUT /success_stories/1.json
  def update
    respond_to do |format|
      if @success_story.update(success_story_params)
        format.html { redirect_to @success_story, notice: 'Success story was successfully updated.' }
        format.json { render :show, status: :ok, location: @success_story }
      else
        format.html { render :edit }
        format.json { render json: @success_story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /success_stories/1
  # DELETE /success_stories/1.json
  def destroy
    @success_story.destroy
    respond_to do |format|
      format.html { redirect_to success_stories_url, notice: 'Success story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_success_story
      @success_story = SuccessStory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def success_story_params
      params.fetch(:success_story, {})
    end
end
