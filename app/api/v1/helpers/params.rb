module V1
  module Helpers
    module Params
      def camelize(params)
        params.deep_transform_keys! do |key|
          camelized = key.to_s.camelize
          camelized[0] = camelized[0].swapcase
          camelized.to_sym
        end
      end

      def snake_declared_params
        camelize(declared(params))
      end

      def snake_params
        camelize(params)
      end
    end
  end
end
