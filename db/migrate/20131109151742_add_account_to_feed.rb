class AddAccountToFeed < ActiveRecord::Migration
  def change
    add_reference :feeds, :account, index: true
  end
end
