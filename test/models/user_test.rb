require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid user" do
    user = User.new(
      name: 'Test',
      surname: 'User',
      email: 'test.user@email.com',
      password: 'blehbleh',
      password_confirmation: 'blehbleh'
    )

    assert user.valid?
  end

  test "invalid without email" do
    user = User.new(
      name: 'Test',
      surname: 'User'
    )

    refute user.valid?
    assert_not_nil user.errors[:email]
  end

  test "invalid without name" do
    user = User.new(
      surname: 'User',
      email: 'test.user@email.com'
    )

    refute user.valid?
    assert_not_nil user.errors[:name]
  end

  test "invalid without surname" do
    user = User.new(
      name: 'Test',
      email: 'test.user@email.com'
    )

    refute user.valid?
    assert_not_nil user.errors[:surname]
  end
end
