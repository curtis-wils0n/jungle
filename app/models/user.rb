class User < ApplicationRecord
  
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true

  def authenticate_with_credentials(email, password)
    email = email.strip
    @user = User.where("email ILIKE ?", email).first
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end

end
