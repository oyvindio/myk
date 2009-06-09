class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
 before_filter :check_administrator_role,:only=>[:index,:destroy]

  def new
    @user = User.new
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = t('suc_account_reg')
      redirect_back_or_default profile_path
    else
      render :action => :new
    end
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = t('suc_account_update')
      redirect_to profile_path
    else
      render :action => :edit
    end
  end
end
