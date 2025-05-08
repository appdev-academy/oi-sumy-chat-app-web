# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id
  field :email_address

  view :extended do
    field :jwt_token
  end
end
