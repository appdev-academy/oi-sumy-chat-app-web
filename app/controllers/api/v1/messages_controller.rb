class Api::V1::MessagesController < Api::V1::BaseController
  # @route GET /api/v1/messages (api_v1_messages)
  def index
    messages = MessageBlueprint.render(Message.order(id: :asc).limit(1000))
    render json: messages, status: :ok
  end

  # @route POST /api/v1/messages (api_v1_messages)
  def create
    message = Message.new(message_params)
    message.user = current_user

    if message.save
      render json: MessageBlueprint.render(message), status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.permit(:content)
  end
end
