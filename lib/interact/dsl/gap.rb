# frozen_string_literal: true

module Interact
  module DSL
    module Gap
      def gap(
        width: :inherit,
        height: :inherit
      )
        empty = ::Interact::Components::Gap.new(parent: self, width: width, height: height)
        children << empty
      end
    end
  end
end
