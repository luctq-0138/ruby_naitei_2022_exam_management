class UsersController < ApplicationController
  def show
    @user = User.find_by id: params[:id]
    retun if @user

    # i18n later
    flash[:danger] = "Cant find user"
    redirect_to root_path
  end

  def new
    @user = User.new
    return if @user

    # i18n later
    flash[:danger] = "Cant find user"
    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = "Dang ky thanh cong"
      redirect_to root_path
    else
      # i18n later
      flash[:error] = "error"
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
