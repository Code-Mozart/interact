# frozen_string_literal: true

module Interact
  module Components
    class Column < Container
      include ::Interact::DSL::Gap
      include ::Interact::DSL::Row
      include ::Interact::DSL::Column
      include ::Interact::DSL::Button

      def size_when_fit
        @size_when_fit ||= (
          widths, heights = children.map(&:size_when_fit).transpose
          [
            padding.west + widths.max + padding.east,
            padding.north + heights.sum + (children.count - 1) * gap_between_children + padding.south
          ]
        )
      end
    end
  end
end
