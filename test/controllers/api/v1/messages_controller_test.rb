require 'test_helper'

class Api::V1::MessagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    Message.destroy_all
    @user1 = User.create!(email_address: 'test01@test.com', password: '1234')
    @user2 = User.create!(email_address: 'test02@test.com', password: '1234')
    @message1 = Message.create!(content: 'Message 1', user: @user1)
    @message2 = Message.create!(content: 'Message 2', user: @user2)
    @message3 = Message.create!(content: 'Message 3', user: @user1)
    @message4 = Message.create!(content: 'Message 4', user: @user2)
  end

  test '#index should return list of Messages if authenticated' do
    get '/api/v1/messages', headers: { 'X-API-Token': @user1.jwt_token }
    assert_response :ok

    json = JSON.parse(response.body)
    assert_equal json.count, 4
    assert_equal json.first['id'], @message1.id
    assert_equal json.last['id'], @message4.id
  end

  test '#index should return 401 status code when UNAUTHENTICATED' do
    get '/api/v1/messages'
    assert_response :unauthorized

    json = JSON.parse(response.body)
    assert_equal json['errors'], ['Missing authentication header']
  end

  test '#create should create and return new Message when authenticated' do
    headers = { 'X-API-Token': @user1.jwt_token }
    params = { content: 'Test message #create' }
    post '/api/v1/messages', headers: headers, params: params

    assert_response :created

    message = JSON.parse(response.body)
    assert_not_nil message['id']
    assert_equal message['content'], 'Test message #create'
    assert_equal message['user']['id'], @user1.id
  end

  test '#create should return 401 status code when UNAUTHENTICATED' do
    params = { content: 'Test message #create' }
    post '/api/v1/messages', params: params
    assert_response :unauthorized

    json = JSON.parse(response.body)
    assert_equal json['errors'], ['Missing authentication header']
  end
end
