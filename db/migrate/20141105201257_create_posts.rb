class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :category, index: true
      t.text :body
      t.string :title
      t.datetime :published_at

      t.timestamps
    end
  end
end
