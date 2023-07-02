# frozen_string_literal: true

module Interact
  module DSL
    module Button
      def button(
        translation_key = nil,
        text: nil,
        width: :inherit,
        height: :inherit,
        horizontal_alignment: :center,
        vertical_alignment: :center,
        &callback
      )
        unless translation_key.nil? or text.nil?
          raise ArgumentError, "Either pass 'translation_key' or a 'text' option but not both"
        end

        button = ::Interact::Components::Button.new(
          parent: self,
          width: width,
          height: height,
          content: { translate: translation_key } || { text: text },
          horizontal_alignment: horizontal_alignment,
          vertical_alignment: vertical_alignment,
          callback: callback
        )
        children << button
      end
    end
  end
end
