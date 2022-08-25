class RegistrationsController < Devise::RegistrationsController
  def after_update_path_for _
    if current_user.admin?
      admin_root_path
    else
      root_path
    end
  end
end
