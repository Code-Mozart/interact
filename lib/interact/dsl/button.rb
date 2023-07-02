# frozen_string_literal: true

module Interact
  module DSL
    module Button
      def button(
        content,
        width: :inherit,
        height: :inherit,
        horizontal_alignment: :center,
        vertical_alignment: :center,
        &callback
      )
        button = ::Interact::Components::Button.new(
          parent: self,
          width: width,
          height: height,
          content: content,
          horizontal_alignment: horizontal_alignment,
          vertical_alignment: vertical_alignment,
          callback: callback
        )
        children << button
      end
    end
  end
end
