class AddRepoToHelpRequests < ActiveRecord::Migration
  def change
    add_column :help_requests, :repo, :string
  end
end
