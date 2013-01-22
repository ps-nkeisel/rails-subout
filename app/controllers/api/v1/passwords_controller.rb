class Api::V1::PasswordsController < Api::V1::BaseController
  skip_before_filter :restrict_access

  def create
    user = User.send_reset_password_instructions(params[:user])
    if user.errors.blank?
      render json: {}
    else
      respond_with_namespace(user)
    end
  end

  def update
    user = User.reset_password_by_token(params[:user])
    if user.errors.empty?
      render json: {}
    else
      respond_with_namespace(user)
    end
  end
end