class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  skip_before_filter :authenticate_admin!, :only => [:show]

  # GET /categories
  def index
    @categories = Category.all
  end

  # GET /categories/1
  def show
    raise ActiveRecord::RecordNotFound if @category.blank?
    if @category.posts.size == 1
      @post = @category.posts.first
      render "posts/show"
    end
  end

  # GET /categories/new
  def new
    @categories = Category.all
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    @categories = Category.all
  end

  # POST /categories
  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to category_clean_path(@category), notice: 'Category was successfully created.'
    else
      @categories = Category.all
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      @categories = Category.all
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find_by(slug: params[:slug])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :parent_id, :is_visual)
    end
end
