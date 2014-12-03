module V1
  class DeleteOwnAccountService
    attr_reader :user, :params

    def initialize(user)
      @user = user
    end

    def call
      return if @user.nil?
      @user.destroy!
    end
  end
end
