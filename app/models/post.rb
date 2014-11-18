class Post < ActiveRecord::Base
  belongs_to :category
  has_many :file_assets
  default_scope { order('published_at DESC, title DESC') }

  before_validation :create_slug
  validates :title, presence: true, allow_blank: false
  validates :slug, presence: true, allow_blank: false, uniqueness: true

  def image_assets
    return self.file_assets.select{ |f| f.is_image? }
  end

  def next
    current = nil
    category.posts.where('published_at >= ?', published_at).each do |p|
      if p.id == id then break else current = p end
    end
    return current
  end

  def previous
    current = nil
    category.posts.where('published_at <= ?', published_at).reverse.each do |p|
      if p.id == id then break else current = p end
    end
    return current
  end

  def to_param
    return slug
  end

  def create_slug
    self.slug = self.title.to_s.parameterize
  end


end
