require 'test_helper'

class FileAssetsControllerTest < ActionController::TestCase
  setup do
    @file_asset = file_assets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:file_assets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create file_asset" do
    assert_difference('FileAsset.count') do
      post :create, file_asset: { content: @file_asset.content, name: @file_asset.name, post_id: @file_asset.post_id }
    end

    assert_redirected_to file_asset_path(assigns(:file_asset))
  end

  test "should show file_asset" do
    get :show, id: @file_asset
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @file_asset
    assert_response :success
  end

  test "should update file_asset" do
    patch :update, id: @file_asset, file_asset: { content: @file_asset.content, name: @file_asset.name, post_id: @file_asset.post_id }
    assert_redirected_to file_asset_path(assigns(:file_asset))
  end

  test "should destroy file_asset" do
    assert_difference('FileAsset.count', -1) do
      delete :destroy, id: @file_asset
    end

    assert_redirected_to file_assets_path
  end
end
