class AddImageToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :image, :string
  end
end
