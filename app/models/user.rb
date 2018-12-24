class User < ApplicationRecord
  has_secure_password
  has_secure_token

  validates :email, presence: true
  validates :username, presence: true

  has_many :project_memberships
  has_many :projects, through: :project_memberships

  after_create :generate_confirmation_token

  def self.valid_login?(params)
    user = find_by(email: params["email"])
    if user && user.authenticate(params["password"])
      user
    end
  end

  # This method is not available in has_secure_token
  def invalidate_token
    self.update_columns(token: nil)
  end

  def verify_email
    self.email_confirmed = true
    self.confirmation_token = nil

    save!(validate: false)
  end

  private

  def generate_confirmation_token
    if self.confirmation_token.blank?
      self.confirmation_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
