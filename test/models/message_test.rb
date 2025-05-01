require "test_helper"

class MessageTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
  end

  test "should NOT save Message without content" do
    message = Message.new(user: @user)
    assert_not message.save
    assert_includes message.errors[:content], "can't be blank"
  end

  test "should save Message with :content" do
    message = Message.new(content: "What's up?", user: @user)
    assert message.save
  end
end
