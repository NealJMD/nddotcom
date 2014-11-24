class AddIsVisualToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :is_visual, :boolean, :default => :false
  end
end
