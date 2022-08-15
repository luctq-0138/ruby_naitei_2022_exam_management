class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      handle_log_in user
    else
      flash.now[:error] = t ".invalid_email_password_combination"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def handle_log_in user
    log_in user
    flash[:success] = t ".login_success"
    if user.admin?
      redirect_back_or admin_root_path
    else
      redirect_back_or root_path
    end
  end
end
