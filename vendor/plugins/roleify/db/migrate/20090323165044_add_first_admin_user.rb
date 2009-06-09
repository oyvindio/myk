class AddFirstAdminUser < ActiveRecord::Migration
  def self.up
      admin_user = User.create(:username=>'admin',
                    :login=>"admin@admin.net",
                    :password=>'admin',:password_confirmation=>'admin')
      admin_role = Role.find_by_name('Administrator')
      admin_user.roles << admin_role
  end

  def self.down
    User.find_by_username('Admin').destroy

  end
end
