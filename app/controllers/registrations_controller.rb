class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
    user_path(resource)
  end

  private

  def sign_up_params
    params.require(:user).permit(:cover_image, :picture, :first_name, :last_name, :email, :display_name, :password, :password_confirmation, :description, :social_media_1, :social_media_2, :social_media_3, :social_media_4, :show_email)
  end

  def account_update_params
    params.require(:user).permit(:cover_image, :picture, :first_name, :last_name, :email, :display_name, :password, :password_confirmation, :description, :social_media_1, :social_media_2, :social_media_3, :social_media_4, :show_email)
  end
end