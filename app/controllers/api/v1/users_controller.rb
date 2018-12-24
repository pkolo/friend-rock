class Api::V1::UsersController < Api::V1::ApiController
  skip_before_action :require_login, only: [:create, :verify_email], raise: false

  def create
    @user = User.new(user_params)

    if @user.save
      UserMailer.registration_confirmation(@user).deliver

      head :ok
    else
      render_unauthorized("Error with your login or password")
    end
  end

  def verify_email
    user = find_user_by_confirmation_token

    if user
      user.verify_email
      # TODO: 'Redirect' to login screen
      head :ok
    else
      render_unauthorized("Error with your verification")
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username)
  end

  def find_user_by_confirmation_token
    if user = User.find_by(confirmation_token: params[:id])
      ActiveSupport::SecurityUtils.secure_compare(
                      ::Digest::SHA256.hexdigest(token),
                      ::Digest::SHA256.hexdigest(user.token))
      user
    end
  end
end
