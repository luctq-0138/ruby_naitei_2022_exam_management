class Admin::UsersController < Admin::BaseController
  def index
    @search = User.ransack email_cont: params[:q] ? params[:q][:email] : ""
    @pagy, @user_item = pagy @search.result.user, items: Settings.pagy
  end
end
