class FileAssetsController < ApplicationController
  before_action :set_file_asset, only: [:show, :edit, :update, :destroy]

  # GET /file_assets
  def index
    @file_assets = FileAsset.all
  end

  # GET /file_assets/1
  def show
  end

  # GET /file_assets/new
  def new
    @posts = Post.all
    @file_asset = FileAsset.new
  end

  # GET /file_assets/1/edit
  def edit
    @posts = Post.all
  end

  # POST /file_assets
  def create
    @file_asset = FileAsset.new(file_asset_params)

    if @file_asset.save
      redirect_to @file_asset, notice: 'File asset was successfully created.'
    else
      @posts = Post.all
      render :new
    end
  end

  # PATCH/PUT /file_assets/1
  def update
    if @file_asset.update(file_asset_params)
      redirect_to @file_asset, notice: 'File asset was successfully updated.'
    else
      @posts = Post.all
      render :edit
    end
  end

  # DELETE /file_assets/1
  def destroy
    @file_asset.destroy
    redirect_to file_assets_url, notice: 'File asset was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_file_asset
      @file_asset = FileAsset.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def file_asset_params
      params.require(:file_asset).permit(:name, :content, :post_id)
    end
end
