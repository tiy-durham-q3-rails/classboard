class AddTeacherToUsers < ActiveRecord::Migration
  def change
    add_column :users, :teacher, :boolean, :null => false, :default => false
  end
end
