class Post < ActiveRecord::Base
  belongs_to :category
  has_many :file_assets

  def image_assets
    return self.file_assets.select{ |f| f.is_image? }
  end

end
