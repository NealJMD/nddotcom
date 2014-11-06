class Category < ActiveRecord::Base
  extend ActsAsTree::TreeWalker

  acts_as_tree order: "name"

  validates :name, presence: true, allow_blank: false

end
