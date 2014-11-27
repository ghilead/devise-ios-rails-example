module V1
  class ErrorFormatter
    def self.call(message, backtrace, options, env)
      error = Error.new(message: message)

      { error: error }.to_json
    end
  end
end
