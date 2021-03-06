class Category < ActiveRecord::Base
  extend ActsAsTree::TreeWalker

  acts_as_tree order: "name"
  has_many :posts
  before_validation :create_slug

  validates :name, presence: true, allow_blank: false
  validates :slug, presence: true, allow_blank: false, uniqueness: true
  validate :no_loops

  def ancestry
    out, current = [self.name], self
    while not current.parent.nil?
      out << current.parent.name
      current = current.parent
    end
    return out.reverse.join(" - ")
  end

  def to_param
    return slug
  end

  def create_slug
    self.slug = self.name.to_s.parameterize
  end

  private

  def no_loops
    max_depth, current_depth, current = 500, 0, self
    seen = []
    (0...max_depth).each do |depth|
      if current.nil? then return end
      if seen.include? current.id
        errors.add(:parent_id, "creates a loop after traversing #{depth} times up the tree.")
        return
      end
      seen << current.id
      current = current.parent
    end
    errors.add(:parent_id, "did not reach a root node within #{max_depth} traversals up the tree.")
  end

end
