class AddLocationToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :latitude, :float
    add_column :feeds, :longitude, :float
    add_column :feeds, :location, :string
  end
end
