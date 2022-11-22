require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is valid when all fields are filled' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: 'test',
        password_confirmation: 'test'
      )
      expect(@user.valid?).to be true
    end
    # Password tests
    it 'must include password and confirmation fields' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: nil,
        password_confirmation: nil
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")

      @user.password = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")

      @user.password_confirmation = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to be_empty
    end

    it 'must include matching password and password confirmation' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: 'test',
        password_confirmation: 'tesssst'
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")

      @user.password_confirmation = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to be_empty
    end

    it 'must include a password longer than 3 characters' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: 'tes',
        password_confirmation: 'tes'
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")

      @user.password = 'test'
      @user.password_confirmation = 'test'
      @user.valid?
      expect(@user.errors.full_messages).to be_empty
    end
    # Email tests
    it 'must include an email field' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: nil,
        password: 'test',
        password_confirmation: 'test'
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
      
      @user.email = 'test@test.com'
      @user.valid?
      expect(@user.errors.full_messages).to be_empty
    end

    it 'must include a unique email address' do
      @user1 = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: 'test',
        password_confirmation: 'test'
      )
      @user1.save!

      @user2 = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: 'test',
        password_confirmation: 'test'
      )
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")

      @user2.email = 'TEST@test.com'
      @user2.valid?
      expect(@user2.errors.full_messages).to include("Email has already been taken")

      @user2.email = 'test2@test.com'
      @user2.valid?
      expect(@user2.errors.full_messages).to be_empty

    end
    # Name tests
    it 'must include a first and last name field' do
      @user = User.new(
        first_name: nil,
        last_name: nil,
        email: 'test@test,com',
        password: 'test',
        password_confirmation: 'test'
      )
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")

      @user.first_name = 'Test'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name can't be blank")

      @user.last_name = 'McTest'
      @user.valid?
      expect(@user.errors.full_messages).to be_empty
    end
  end

  describe '.authenticate_with_credentials' do
    it 'is valid when given valid information' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: 'test',
        password_confirmation: 'test'
      )
      @user.save

      @user = @user.authenticate_with_credentials('test@test.com', 'test')
      expect(@user).to_not be(nil)
    end

    it 'is invalid when given invalid information' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: 'test',
        password_confirmation: 'test'
      )
      @user.save

      @user = @user.authenticate_with_credentials('test@test.com', 'tessssst')
      expect(@user).to be(nil)
    end

    it 'is valid when given an email with spaces at either end' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: 'test',
        password_confirmation: 'test'
      )
      @user.save

      @user = @user.authenticate_with_credentials('   test@test.com   ', 'test')
      expect(@user).to_not be(nil)
    end

    it 'is valid when given an email typed in incorrect case' do
      @user = User.new(
        first_name: 'Test',
        last_name: 'McTest',
        email: 'test@test.com',
        password: 'test',
        password_confirmation: 'test'
      )
      @user.save

      @user = @user.authenticate_with_credentials('TeSt@TeSt.CoM', 'test')
    end
  end
end
