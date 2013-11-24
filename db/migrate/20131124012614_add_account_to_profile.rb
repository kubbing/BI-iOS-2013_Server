class AddAccountToProfile < ActiveRecord::Migration
  def change
    add_reference :profiles, :account, index: true
  end
end
