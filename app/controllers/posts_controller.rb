class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new, :create, :update]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_bg_white

  def index
    params[:page] ||= 1

    @page_title = 'Success Stories'
    @posts = Post.page(params[:page]).per(24).order(created_at: :desc)

    @index_from = (@posts.prev_page || 0) * @posts.limit_value + 1
    @index_to = [@index_from + @posts.limit_value - 1, @posts.total_count].min
    @total_count = @posts.total_count
  end

  def show
  end

  def new
    unless current_user.is_admin?
      flash[:message] = 'You have to be an admin to add posts.'

      return redirect_to posts_path
    end

    @post = Post.new
  end

  def edit
    unless current_user.is_admin?
      flash[:message] = 'You have to be an admin to add posts.'

      return redirect_to posts_path
    end
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Story was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Story was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.fetch(:post, {}).permit(:title, :body, :links, :image, :project_ids)
    end
end
