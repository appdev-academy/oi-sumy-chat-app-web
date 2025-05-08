require 'application_system_test_case'

class MessagesTest < ApplicationSystemTestCase
  setup do
    @user = User.create!(email_address: 'test@test.com', password: '1234')
    @message = messages(:one)
  end

  test 'can see Messages' do
    visit messages_url

    fill_in 'email_address', with: @user.email_address
    fill_in 'password', with: @user.password
    click_on 'Sign in'

    assert_selector 'div', text: 'Sent by'
  end
end
