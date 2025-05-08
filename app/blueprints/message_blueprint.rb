# frozen_string_literal: true

class MessageBlueprint < Blueprinter::Base
  identifier :id

  field :content
  field :created_at, datetime_format: ->(datetime) { datetime.iso8601 }

  association :user, blueprint: UserBlueprint
end
