class CreateAllowedAccounts < ActiveRecord::Migration
  def change
    create_table :allowed_accounts do |t|
      t.string :github

      t.timestamps
    end
  end
end
