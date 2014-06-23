class CreateHelpRequests < ActiveRecord::Migration
  def change
    create_table :help_requests do |t|
      t.text :nature
      t.text :attempted
      t.datetime :resolved_at

      t.timestamps
    end
  end
end
