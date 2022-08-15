class Admin::ProfileController < Admin::BaseController
  before_action :find_user, :logged_in_user, :correct_user,
                only: %i(edit update)

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
