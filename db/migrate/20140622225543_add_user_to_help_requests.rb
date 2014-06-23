class AddUserToHelpRequests < ActiveRecord::Migration
  def change
    add_reference :help_requests, :user, index: true
  end
end
