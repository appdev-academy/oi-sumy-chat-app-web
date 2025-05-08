class Api::V1::UsersController < Api::V1::BaseController
  # @route POST /api/v1/users (api_v1_users)
  def create
    user = User.new(user_params)
    if user.save
      render json: UserBlueprint.render(user), status: :created
    else
      render json: { errors: ['Invalid email or password'] }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email_address, :password)
  end
end
