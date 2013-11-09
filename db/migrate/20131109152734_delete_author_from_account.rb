class DeleteAuthorFromAccount < ActiveRecord::Migration
  def change
	remove_column :feeds, :author
  end
end
