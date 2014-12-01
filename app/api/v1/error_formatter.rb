module V1
  class ErrorFormatter
    def self.call(user_error, backtrace, options, env)
      error = if user_error.is_a? Error
        user_error
      else
        Error.new(message: user_error, status: 500)
      end

      { error: error }.to_json
    end
  end
end
