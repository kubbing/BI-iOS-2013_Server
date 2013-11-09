class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :alert
      t.integer :badge
      t.text :data
      t.string :sound
      t.string :token

      t.timestamps
    end
  end
end
