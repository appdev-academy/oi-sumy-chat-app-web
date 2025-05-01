require "test_helper"

class MessageTest < ActiveSupport::TestCase
  test "should NOT save Message without content" do
    message = Message.new
    assert_not message.save
    assert_includes message.errors[:content], "can't be blank"
  end

  test "should save Message with :content" do
    message = Message.new(content: "What's up?")
    assert message.save
  end
end
