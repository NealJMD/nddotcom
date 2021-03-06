class PostsController < ApplicationController
  skip_before_filter :authenticate_admin!, :only => [:show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
  end

  # GET /posts/1
  def show
    if @post.nil?
      render Category.find_by(slug: params[:slug])
    end
  end

  # GET /posts/new
  def new
    @categories = Category.all
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @categories = Category.all
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      @categories = Category.all
      render :new
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      @categories = Category.all
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find_by(slug: params[:slug])
    end

    # Only allow a trusted parameter "white list" through.
    def post_params
      params.require(:post).permit(:category_id, :body, :title, :is_single_image, :published_at)
    end
end
