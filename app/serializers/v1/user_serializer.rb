module V1
  class UserSerializer < BaseSerializer
    attributes \
      :id,
      :email,
      :authentication_token,
      :reset_password_token,
      :reset_password_sent_at,
      :created_at,
      :updated_at
  end
end
