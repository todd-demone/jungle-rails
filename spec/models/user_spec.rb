require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validate Users" do
    it "should pass when everything is filled in correctly" do
      @user = User.new do |u|
        u.first_name = "Jane"
        u.last_name = "Doe"
        u.email = "jane@gmail.com"
        u.password = "123"
        u.password_confirmation = "123"
      end
      
    end
    # it "should fail when there is no first_name" do
    #   expect().to 
    # end
    # it "should fail when there is no last_name" do
    #   expect().to 
    # end
    # it "should fail when there is no email address" do
    #   expect().to 
    # end
    # it "should fail when there is no password" do
    #   expect().to 
    # end
    # it "should fail when there is no first_name" do
    #   expect().to 
    # end
    # it "should fail when the password and password_combination do not match" do
    #   expect().to 
    # end
    # it "should fail when the email is not unique" do
    #   expect().to 
    # end
  end
end
