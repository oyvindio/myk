module RoleifyModelStuff
  def has_role?(rolename)
    self.roles.find_by_name(rolename) ? true : false
  end
end
