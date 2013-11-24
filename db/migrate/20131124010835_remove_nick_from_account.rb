class RemoveNickFromAccount < ActiveRecord::Migration
  def change
    remove_column :accounts, :nick
  end
end
