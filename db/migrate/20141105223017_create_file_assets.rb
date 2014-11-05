class CreateFileAssets < ActiveRecord::Migration
  def change
    create_table :file_assets do |t|
      t.string :name
      t.attachment :content
      t.references :post, index: true

      t.timestamps
    end
  end
end
