class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:cover_image, :picture, :first_name, :last_name, :email, :password, :password_confirmation, :description, :phone)
  end

  def account_update_params
    params.require(:user).permit(:cover_image, :picture, :first_name, :last_name, :email, :password, :password_confirmation, :current_password, :description, :phone)
  end
end