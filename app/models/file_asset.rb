class FileAsset < ActiveRecord::Base
  belongs_to :post

  has_attached_file :content, {
    styles: {
      square: '200x200#',
      medium: '300x300>'
    }
  }.merge(PAPERCLIP_FILE_ASSET_STORAGE_OPTIONS)

  before_post_process :is_image?

  validates_attachment_presence :content
  validates_attachment_size :content, :less_than => 200.megabytes

  validates :name, presence: true
  validates :post, presence: true

  # it's only me that's using the admin, so I want to be able to upload arbitrary files
  do_not_validate_attachment_file_type :content

  def is_image?
    image_types = ["image/tiff", "image/jpeg", "image/jpg", "image/png", "image/x-png", "image/gif"]
    return image_types.include?(self.content_content_type)
  end

end
