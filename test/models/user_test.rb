require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # Test for firstname

  test "firstname not present" do 
    user = User.create(firstname: nil, lastname: 'Doe', email: 'jondoe@anonymous.com', password: 'jondoe123', is_admin: true)
    assert user.errors.full_messages.include?("Firstname can't be blank") 
  end

  test "firstname is only letters" do
    user = User.create(firstname: 'jon12', lastname: 'Doe', email: 'jondoe@anonymous.com', password: 'jondoe123', is_admin: true)
    assert user.errors.full_messages.include?("Firstname only allows letters") 
  end

  # Test for lastname

  test "lastname not present" do 
    user = User.create(firstname: 'Jon', lastname: nil, email: 'jondoe@anonymous.com', password: 'jondoe123', is_admin: true)
    assert user.errors.full_messages.include?("Lastname can't be blank")
  end 

  test "lastname is only letters" do
    user = User.create(firstname: 'Jon', lastname: 'Doe1', email: 'jondoe@anonymous.com', password: 'jondoe123', is_admin: true)
    assert user.errors.full_messages.include?("Lastname only allows letters") 
  end

  # Test for email

  test "email is unique" do 
    user1 = User.create(firstname: 'Jon', lastname: 'Doe', email: 'jondoe@anonymous.com', password: 'jondoe123', is_admin: true)
    user2 = User.create(firstname: 'Jon', lastname: 'Doe', email: 'jondoe@anonymous.com', password: 'jondoe123', is_admin: true)
    assert user2.errors.full_messages.include?("Email has already been taken")
  end

  test "email is valid" do
    user = User.create(firstname: 'Jon', lastname: 'Doe', email: 'jondoeanonymouscom', password: 'jondoe123', is_admin: true)
    assert user.errors.full_messages.include?("Email not a valid email")
  end

  # Test for password

  test "password length valid" do 
    user = User.create(firstname: 'Jon', lastname: 'Doe', email: 'jondoe@anonymous.com', password: 'jo', is_admin: true)
    assert user.errors.full_messages.include?("Password is too short (minimum is 6 characters)")
  end

  # Test for authenticate

  test "user authenticates" do
    user = users(:jon)
    user = User.authenticate(email: user.email, password: user.password)
    assert_kind_of User, user, "Failed to authenticate"
  end

end