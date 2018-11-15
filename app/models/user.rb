class User < ApplicationRecord 
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: {maximum: settings.maximum_email},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {maximum: settings.maximum_password} 
  validates :name, presence: true, length: {maximum: settings.maximum_name}
  
  before_save :downcase_email

  has_secure_password

  private 
  
  def downcase_email
    email.downcase!
  end
end
