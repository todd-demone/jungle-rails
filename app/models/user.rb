class User < ActiveRecord::Base
  # password validations
  has_secure_password
  validates :password, length: {minimum: 8}
  validates_presence_of :password_confirmation

  # name and email validations
  validates_presence_of :first_name
  validates_presence_of :last_name
  # validates_presence_of :email
  # validates_uniqueness_of :email
  validates :email, presence: true, uniqueness: true
  
  def self.authenticate_with_credentials(email, password)
    squished_email = email.squish
    user = User.find_by_email(squished_email)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end
