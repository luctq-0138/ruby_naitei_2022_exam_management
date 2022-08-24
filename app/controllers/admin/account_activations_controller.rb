class Admin::AccountActivationsController < Admin::BaseController
  before_action :find_user, only: %i(update)

  def update
    if @user && !@user.activated?
      active_user
    elsif @user&.activated?
      inactive_user
    else
      flash[:danger] = t ".fail_activated"
    end
    redirect_to admin_users_path
  end

  def active_user
    @user.activate_or_inactive
    flash[:success] = t ".success_activated"
  end

  def inactive_user
    @user.activate_or_inactive
    flash[:success] = t ".success_inactivated"
  end
end
