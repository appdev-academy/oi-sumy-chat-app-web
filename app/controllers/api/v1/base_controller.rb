class Api::V1::BaseController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :authenticate

  attr_reader :current_user

  private

  def authenticate
    access_token = request.headers['X-API-Token']
    unless access_token
      return render json: { errors: ['Missing authentication header'] }, status: :unauthorized
    end

    begin
      jwt = JWT.decode(access_token, Rails.application.credentials.jwt_secret)
    rescue JWT::DecodeError
      return render json: { errors: ['Invalid authentication header'] }, status: :unauthorized
    end

    jwt_payload = jwt[0]
    user_id = jwt_payload['id']
    @current_user = User.find(user_id)
  end
end
