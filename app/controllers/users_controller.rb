class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create]
  before_action :resume_session, only: [:new, :create]

  # @route GET /users/new (new_user)
  def new
    @user = User.new
  end

  # @route POST /users (users)
  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user
      redirect_to messages_path, notice: 'You have signed up!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [:email_address, :password, :password_confirmation])
  end
end
