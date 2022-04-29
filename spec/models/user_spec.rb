require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User validations" do
    it "allows User creation when all required fields are set" do
      @user = User.create!(first_name: "Jane", last_name: "Doe", email: "jane@gmail.com", password: "password", password_confirmation: "password")
      expect(User.count).to eq(1)
    end
    describe "prohibits User creation when" do
      it "first_name is empty" do
        @user = User.create(first_name: nil, last_name: "Doe", email: "jane@gmail.com", password: "password", password_confirmation: "password")
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it "last_name is empty" do
        @user = User.create(first_name: "Jane", last_name: nil, email: "jane@gmail.com", password: "password", password_confirmation: "password")
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it "email is empty" do
        @user = User.create(first_name: "Jane", last_name: "Doe", email: nil, password: "password", password_confirmation: "password")
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "email already exists" do
        @user_one = User.create(first_name: "Jane", last_name: "Doe", email: "jane@gmail.com", password: "password", password_confirmation: "password")
        @user_two = User.create(first_name: "Janet", last_name: "Doe", email: "jane@gmail.com", password: "password", password_confirmation: "password")
        expect(@user_two.errors.full_messages).to include("Email has already been taken")
      end

      it "email already exists in different case" do
        @user_one = User.create(first_name: "Jane", last_name: "Doe", email: "jane@gmail.com", password: "password", password_confirmation: "password")
        @user_two = User.create(first_name: "Janet", last_name: "Doe", email: "JANE@gmail.com", password: "password", password_confirmation: "password")
        expect(@user_two.errors.full_messages).to include("Email has already been taken")
      end

      it "password is empty" do
        @user = User.create(first_name: "Jane", last_name: "doe", email: "jane@gmail.com", password: nil, password_confirmation: "password")
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "password_confirmation is empty" do
        @user = User.create(first_name: "Jane", last_name: "Doe", email: "jane@gmail.com", password: "password", password_confirmation: nil)
        expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
      end

      it "password and password_confirmation do not match" do
        @user = User.create(first_name: "Jane", last_name: "doe", email: "jane@gmail.com", password: "password", password_confirmation: "doesNotMatch")
        expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
      end

      it "password is not at least 8 characters long" do
        @user = User.create(first_name: "Jane", last_name: "doe", email: "jane@gmail.com", password: "123", password_confirmation: "123")
        expect(@user.errors.full_messages).to include ("Password is too short (minimum is 8 characters)")
      end
    end

    describe ".authenticate_with_credentials" do
      context "passed correct email and password" do
        it "should return a user object when authentication is successful" do
          @user = User.create!(first_name: "Jane", last_name: "Doe", email: "jane@gmail.com", password: "password", password_confirmation: "password")
          expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
        end
      end

      context "passed incorrect password" do
        it "should return nil because login is unsuccessful" do
          @user = User.create!(first_name: "Jane", last_name: "Doe", email: "jane@gmail.com", password: "password", password_confirmation: "password")
          expect(User.authenticate_with_credentials(@user.email, "notCorrectPassword")).to eq(nil)
        end
      end

      context "spaces before and after email address" do
        it "should return user (successful authentication) despite spaces before/after email address" do
          @user = User.create!(first_name: "Jane", last_name: "Doe", email: "jane@gmail.com", password: "password", password_confirmation: "password")
          expect(User.authenticate_with_credentials("   jane@gmail.com   ", @user.password)).to eq(@user)
        end
      end
    end
  end
end
