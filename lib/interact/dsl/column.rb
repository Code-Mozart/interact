# frozen_string_literal: true

module Interact
  module DSL
    module Column
      def column(
        width: :inherit,
        height: :inherit,
        default_child_height: :expand,
        alignment: :center,
        gap_between_children: 5,
        &block
      )
        column = ::Interact::Components::Column.new(
          parent: self,
          width: width,
          height: height,
          default_child_size: default_child_height,
          alignment: alignment,
          gap_between_children: gap_between_children
        )
        children << column
        column.instance_eval &block
      end
    end
  end
end
