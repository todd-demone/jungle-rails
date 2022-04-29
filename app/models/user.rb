class User < ActiveRecord::Base
  # password validations
  has_secure_password

  # name and email validations
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_uniqueness_of :email #, :case_sensitive => false
  
end
