class User < ActiveRecord::Base
  acts_as_authentic
  #acts_as_authentic
  validates_presence_of :username
  validates_length_of :username,:maximum=> 10
  
  validates_format_of :login,
      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
      :message => 'email must be valid'
  
  
  has_and_belongs_to_many :roles
  include RoleifyModelStuff
  
       
  def email
    self.login
  end

  def deliver_password_reset_instructions!
    reset_perishable_token!
    Notifier.deliver_password_reset_instructions(self)
  end
end
