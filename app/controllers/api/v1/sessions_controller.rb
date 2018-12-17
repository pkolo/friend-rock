class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :require_login, only: [:create], raise: false

  def create
    if user = User.valid_login?(session_params)
      allow_token_to_be_used_only_once_for(user)
      send_auth_token_for_valid_login_of(user)
    else
      render_unauthorized("Error with your login or password")
    end
  end

  def destroy
    if current_user
      logout
      head :ok
    else
      render_unauthorized("Error with your login or password")
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def send_auth_token_for_valid_login_of(user)
    render json: { email: user.email, token: user.token }
  end

  def allow_token_to_be_used_only_once_for(user)
    user.regenerate_token
  end

  def logout
    current_user.invalidate_token
  end
end
