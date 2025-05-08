require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should create new User & Session when params are valid' do
    post '/api/v1/users', params: { email_address: 'test@test.com', password: '1234' }
    assert_response :created

    json = JSON.parse(response.body)
    assert json.key?('id')
    assert json.key?('email_address')
    assert json.key?('jwt_token')
  end

  test 'should NOT create new User & Session when params are INVALID' do
    user = User.create!(email_address: 'test@test.com', password: '1234')

    post '/api/v1/users', params: { email_address: user.email_address, password: user.password }
    assert_response :unprocessable_entity

    json = JSON.parse(response.body)
    assert_equal json['errors'], ['Invalid email or password']
  end
end
