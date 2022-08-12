class ApplicationController < ActionController::Base
  include SessionsHelper
  include Pagy::Backend
  before_action :set_locale

  private
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    check = I18n.available_locales.include?(locale)
    I18n.locale = check ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user.present?

    flash[:danger] = t "not_found"
    redirect_to signup_path
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "danger"
    redirect_to login_path
  end

  def correct_user
    return if check_correct_user? @user

    flash[:danger] = t "incorrect_user"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
