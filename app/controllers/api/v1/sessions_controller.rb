class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :authenticate

  # @route POST /api/v1/sessions (api_v1_sessions)
  def create
    if user = User.authenticate_by(user_params)
      render json: UserBlueprint.render(user, view: :extended), status: :created
    else
      render json: { errors: ['Invalid email or password'] }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email_address, :password)
  end
end
