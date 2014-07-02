class AddUniqueIndexToAllowedAccountsAndUsers < ActiveRecord::Migration
  def change
    add_index :allowed_accounts, :github, :unique => true
    add_index :users, :github
  end
end
