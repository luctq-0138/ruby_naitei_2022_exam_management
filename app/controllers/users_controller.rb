class UsersController < ApplicationController
  before_action :find_user, except: %i(new create)
  before_action :logged_in_user, :correct_user, only: %i(edit update)

  def show
    return if @user

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
end
