class Admin::AccountActivationsController < Admin::BaseController
  def edit
    user = User.find_by id: params[:id]
    if user && !user.activated?
      active_user user
    elsif user&.activated?
      inactive_user user
    else
      flash[:danger] = t ".fail_activated"
    end
    redirect_to admin_users_path
  end

  def active_user user
    user.activate
    flash[:success] = t ".success_activated"
  end

  def inactive_user user
    user.activate
    flash[:success] = t ".success_inactivated"
  end
end
