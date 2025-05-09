# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id

  field :username

  view :extended do
    field :email_address
    field :jwt_token
  end
end
