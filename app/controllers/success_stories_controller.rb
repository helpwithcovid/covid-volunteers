class SuccessStoriesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new, :create, :update]
  before_action :set_success_story, only: [:show, :edit, :update, :destroy]
  before_action :set_bg_white

  before_action :ensure_admin, only: [ :new, :edit, :create, :update, :destroy ]

  def index
    params[:page] ||= 1

    @page_title = I18n.t('success_stories')
    @success_stories = SuccessStory.page(params[:page]).per(24).order(highlight: :desc, created_at: :desc)

    @index_from = (@success_stories.prev_page || 0) * @success_stories.limit_value + 1
    @index_to = [@index_from + @success_stories.limit_value - 1, @success_stories.total_count].min
    @total_count = @success_stories.total_count
  end

  def show
  end

  def new
    @success_story = SuccessStory.new
  end

  def edit
  end

  def create
    @success_story = SuccessStory.new(success_story_params)

    respond_to do |format|
      if @success_story.save
        format.html { redirect_to @success_story, notice: I18n.t('story_was_successfully_created') }
        format.json { render :show, status: :created, location: @success_story }
      else
        format.html { render :new }
        format.json { render json: @success_story.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @success_story.update(success_story_params)
        format.html { redirect_to @success_story, notice: I18n.t('story_was_successfully_updated') }
        format.json { render :show, status: :ok, location: @success_story }
      else
        format.html { render :edit }
        format.json { render json: @success_story.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @success_story.destroy

    respond_to do |format|
      format.html { redirect_to success_stories_url, notice: I18n.t('story_was_successfully_destroyed') }
      format.json { head :no_content }
    end
  end

  private
    def set_success_story
      @success_story = SuccessStory.find(params[:id])
    end

    def success_story_params
      params.fetch(:success_story, {}).permit(:title, :body, :links, :image, :project_ids, :highlight)
    end
end
