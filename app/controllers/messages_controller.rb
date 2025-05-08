class MessagesController < ApplicationController
  before_action :set_message, only: %i[ show edit update destroy ]

  # @route GET /messages (messages)
  # @route GET / (root)
  def index
    @messages = Message.all
  end

  # @route GET /messages/:id (message)
  def show
  end

  # @route GET /messages/new (new_message)
  def new
    @message = Message.new
  end

  # @route GET /messages/:id/edit (edit_message)
  def edit
  end

  # @route POST /messages (messages)
  def create
    @message = Message.new(message_params)
    @message.user = Current.user

    if @message.save
      respond_to do |format|
        format.html do
          redirect_to @message, notice: "Message was successfully created."
        end
        format.turbo_stream do
          Turbo::StreamsChannel.broadcast_append_to "chat", target: "messages", partial: "messages/message", locals: { message: @message }
          Turbo::StreamsChannel.broadcast_action_to "chat", action: "scroll_to", target: "message_#{@message.id}"

          render turbo_stream: [
            turbo_stream.update("new_message", partial: "messages/form", locals: { message: Message.new })
          ]
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  # @route PATCH /messages/:id (message)
  # @route PUT /messages/:id (message)
  def update
    if @message.update(message_params)
      redirect_to @message, notice: "Message was successfully updated.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # @route DELETE /messages/:id (message)
  def destroy
    @message.destroy!
    redirect_to messages_path, notice: "Message was successfully destroyed.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.expect(message: [ :content ])
    end
end
