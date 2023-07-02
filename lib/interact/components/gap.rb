# frozen_string_literal: true

require 'ruby2d'

module Interact
  module Components
    class Gap < Component
      def size_when_fit
        [0, 0]
      end

      protected

      def validate_desired_size(options)
        [:width, :height].each do |dimension_option|
          opt = options.send dimension_option
          name = dimension_option
          ensure_enum_or_numeric opt, name, [:inherit, :expand]
        end
      end
    end
  end
end
