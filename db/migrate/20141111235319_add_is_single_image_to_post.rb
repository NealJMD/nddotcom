class AddIsSingleImageToPost < ActiveRecord::Migration
  def change
    add_column :posts, :is_single_image, :boolean, :default => false
  end
end
