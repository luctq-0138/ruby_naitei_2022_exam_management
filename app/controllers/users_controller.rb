class UsersController < ApplicationController
  before_action :find_user, except: %i(new create)
  before_action :logged_in_user, :correct_user, only: %i(edit update)

  def show
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

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".update_success"
      redirect_to root_path
    else
      flash.now[:error] = t ".update_false"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user.present?

    flash[:danger] = t ".not_found"
    redirect_to signup_path
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".danger"
    redirect_to login_path
  end

  def correct_user
    return if check_correct_user? @user

    flash[:danger] = t ".incorrect_user"
    redirect_to root_path
  end
end
