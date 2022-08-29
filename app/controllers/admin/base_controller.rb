class Admin::BaseController < ApplicationController
  layout "layouts/application_admin"
  before_action :check_role_user

  private

  def check_role_user
    return if user_signed_in? && current_user.admin?

    flash[:danger] = t "incorrect_admin"
    redirect_to root_path
  end
end
