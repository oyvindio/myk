class CreateRolesUsers < ActiveRecord::Migration
  def self.up
      create_table :roles_users,:id=>false do |t|
      t.column :role_id, :integer, :null=>false
      t.column :user_id,:integer,:null=>false
      end
      
      
  end

  def self.down
    drop_table :roles_users
    User.find_by_username('Admin').destroy
  end
end
