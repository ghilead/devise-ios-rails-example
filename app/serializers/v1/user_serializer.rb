module V1
  class UserSerializer < BaseSerializer
    attributes \
      :id,
      :email,
      :authentication_token,
      :created_at,
      :updated_at
  end
end
