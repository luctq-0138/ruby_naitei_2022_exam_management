class ApplicationController < ActionController::Base
  include Pagy::Backend
  include ApplicationHelper
  before_action :set_locale
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :determine_layout

  def determine_layout
    if !user_signed_in?
      "application"
    else
      (current_user.admin? ? "application_admin" : "application")
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: User::USER_ATTRS
    devise_parameter_sanitizer.permit :account_update, keys: User::USER_ATTRS
  end

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
    redirect_to new_user_registration_path
  end

  def logged_in_user
    return if user_signed_in?

    store_location
    flash[:danger] = t "danger"
    redirect_to login_path
  end

  def correct_user
    return if authenticate_user!

    flash[:danger] = t "incorrect_user"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit User::USER_ATTRS
  end

  def after_sign_in_path_for resource
    unless current_user.activated?
      sign_out
      flash[:warning] = t ".account_not_activated"
      stored_location_for(resource) || root_path
    end
    if current_user&.admin?
      stored_location_for(resource) || admin_root_path
    else
      stored_location_for(resource) || root_path
    end
  end
end
