class User < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.validate.name.max_length}
  
  validates :email, presence: true,
    length: {maximum: Settings.validate.email.max_length},
    format: {with: Settings.validate.email.regex},
    uniqueness: true

  validates :password, presence: true,
    length: {minimum: Settings.validate.password.min_length},
    allow_nil: true
  has_secure_password
  before_save :downcase_email
  
  def User.digest string
    cost = if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create string, cost: cost
  end

  private

  def downcase_email
    email.downcase!
  end

end
