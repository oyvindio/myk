module RoleifySystem
  def check_role(role)
    unless current_user && @current_user.has_role?(role)
      flash[:error]="You don't have permisition to do that"
      redirect_to root_path
    end
  end
  
  def check_administrator_role
    check_role('Administrator')
  end
end
