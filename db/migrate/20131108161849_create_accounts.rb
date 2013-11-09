class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :login
      t.string :nick
      t.string :token

      t.timestamps
    end
  end
end
