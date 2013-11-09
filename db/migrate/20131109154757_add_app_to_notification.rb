class AddAppToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :app, :string
  end
end
