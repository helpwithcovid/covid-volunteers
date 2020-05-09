class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_bg_white

  # GET /posts
  # GET /posts.json
  def index
    params[:page] ||= 1

    @page_title = 'Success Stories'
    @posts = Post.page(params[:page]).per(24).order(created_at: :desc)

    @index_from = (@posts.prev_page || 0) * @posts.limit_value + 1
    @index_to = [@index_from + @posts.limit_value - 1, @posts.total_count].min
    @total_count = @posts.total_count
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    unless current_user.is_admin?
      flash[:message] = 'You have to be an admin to add posts.'

      return redirect_to posts_path
    end

    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    unless current_user.is_admin?
      flash[:message] = 'You have to be an admin to add posts.'

      return redirect_to posts_path
    end
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Success story was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Success story was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Success story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.fetch(:post, {}).permit(:title, :body, :links, :image, :project_ids)
    end
end
