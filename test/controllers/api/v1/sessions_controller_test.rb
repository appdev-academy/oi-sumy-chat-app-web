require 'test_helper'

class Api::V1::SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(email_address: 'test@test.com', password: '1234')
  end

  test 'should create new Session when params are valid' do
    post '/api/v1/sessions', params: { email_address: @user.email_address, password: @user.password }
    assert_response :created

    json = JSON.parse(response.body)
    assert_equal json['id'], @user.id
    assert_equal json['email_address'], @user.email_address
    assert json.key?('jwt_token'), "Expected 'jwt_token' to be present in JSON response"
  end

  test 'should NOT create new Session when params are INVALID' do
    post '/api/v1/sessions', params: { email_address: 'non-existing@user.com', password: @user.password }
    assert_response :unprocessable_entity

    json = JSON.parse(response.body)
    assert_equal json['errors'], ['Invalid email or password']
  end
end
