class RegistrationsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  before_action :resume_session, only: [:new, :create]

  # @route GET /registrations/new (new_registration)
  def new
    return redirect_to root_path if Current.session
    @user = User.new
  end

  # @route POST /registrations (registrations)
  def create
    @user = User.new(user_params)
    @user.email_address = Faker::Internet.unique.email
    @user.password = Faker::Internet.password

    if @user.save
      start_new_session_for @user
      redirect_to after_authentication_url
    else
      render :new, alert: "Щось пішло не так, спробуйте іншe ім'я"
    end
  end

  private

  def user_params
    params.expect(user: [:username])
  end
end
