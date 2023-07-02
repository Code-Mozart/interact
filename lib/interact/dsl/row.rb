# frozen_string_literal: true

module Interact
  module DSL
    module Row
      def row(
        width: :inherit,
        height: :inherit,
        default_child_width: :expand,
        default_child_height: :expand,
        alignment: :center,
        gap_between_children: 5,
        &block
      )
        row = ::Interact::Components::Row.new(
          parent: self,
          width: width,
          height: height,
          default_child_width: default_child_width,
          default_child_height: default_child_height,
          alignment: alignment,
          gap_between_children: gap_between_children
        )
        children << row
        row.instance_eval &block
      end
    end
  end
end
