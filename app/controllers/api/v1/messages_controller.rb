class Api::V1::MessagesController < Api::V1::BaseController
  # @route GET /api/v1/messages (api_v1_messages)
  def index
    messages = MessageBlueprint.render(Message.order(id: :asc).limit(1000))
    render json: messages, status: :ok
  end

  # @route POST /api/v1/messages (api_v1_messages)
  def create
  end
end
