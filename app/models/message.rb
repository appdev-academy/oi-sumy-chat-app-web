class Message < ApplicationRecord
  after_commit :broadcast_changes, on: :create

  belongs_to :user

  validates :content, presence: true

  private

  def broadcast_changes
    Turbo::StreamsChannel.broadcast_append_to 'chat', target: 'messages', partial: 'messages/message', locals: { message: self }
    Turbo::StreamsChannel.broadcast_action_to 'chat', action: 'scroll_to', target: "message_#{self.id}"
    Turbo::StreamsChannel.broadcast_update_to 'chat', target: 'confetti', partial: 'shared/confetti'
  end
end
