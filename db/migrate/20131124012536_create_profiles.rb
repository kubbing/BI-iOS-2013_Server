class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :nick
      t.text :bio
      t.string :image
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
