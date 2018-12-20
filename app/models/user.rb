class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_many :project_memberships
  has_many :projects, through: :project_memberships

  # This method is not available in has_secure_token
  def invalidate_token
    self.update_columns(token: nil)
  end

  def self.valid_login?(params)
    user = find_by(email: params["email"])
    if user && user.authenticate(params["password"])
      user
    end
  end
end
