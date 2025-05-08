require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'username is set automatically on create' do
    user = User.create(email_address: Faker::Internet.unique.email, password: Faker::Internet.password)
    assert_not_nil user.username
  end
end
