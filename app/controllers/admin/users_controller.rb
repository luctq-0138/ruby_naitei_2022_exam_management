class Admin::UsersController < Admin::BaseController
  def index
    @pagy, @user_item = pagy User.user, items: Settings.pagy
  end
end
