class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    retun if @user

    flash.now[:error] = t "not_found"
    redirect_to root_path
  end

  def new
    @user = User.new
    return if @user

    flash.now[:error] = t "not_found"
    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "success_signup"
      redirect_to root_path
    else
      flash.now[:error] = t "fail_signup"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
