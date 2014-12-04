module V1
  module Helpers
    module Params
      def deep_underscore(params)
        params.deep_transform_keys! do |key|
          underscore = key.to_s.underscore
          underscore.to_sym
        end
      end

      def snake_declared_params
        deep_underscore(declared(params))
      end

      def snake_params
        deep_underscore(params)
      end
    end
  end
end
