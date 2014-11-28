class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.downcase }
  validates :email, presence: true, length: {maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  after_create :create_auth_token

  def access_token
    token = ApiToken.active(self).first
    
    if token.blank?
      token = ApiToken.create(user: self, active: true)
    end
    token.access_token
  end

  private

  def create_auth_token
    ApiToken.create(user: self, active: true)
  end
end
