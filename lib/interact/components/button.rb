# frozen_string_literal: true

require 'ruby2d'

module Interact
  module Components
    class Button < Text
      attr_accessor :callback

      def initialize(**options)
        super
        @callback = parse_options(options, :callback).callback
      end

      def to_tree(**options)
        super(**options).merge(
          callback: @callback
        )
      end
    end
  end
end
