module V1
  class UserSerializer < BaseSerializer
    attributes \
      :username,
      :email,
      :authentication_token,
      :created_at,
      :updated_at
  end
end
