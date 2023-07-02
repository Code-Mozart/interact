# frozen_string_literal: true

require 'ruby2d'

module Interact
  module Components
    class Text < Component
      attr_reader :content, :horizontal_alignment, :vertical_alignment, :font_size

      def initialize(**options)
        super

        options = parse_options options, :content, font_size: 12

        @content = options.content
        @horizontal_alignment = options.horizontal_alignment
        @vertical_alignment = options.vertical_alignment
        @font_size = options.font_size
      end

      def size_when_fit
        @size_when_fit ||= (
          temp_text_primitive = Ruby2D::Text.new content, size: font_size
          res = [
            padding.west + temp_text_primitive.width + padding.east,
            padding.north + temp_text_primitive.height + padding.south
          ]
          temp_text_primitive.remove
          res
        )
      end

      def build(x:, y:, width:, height:)
        text_primitive.text = content
        text_primitive.x = x
        text_primitive.y = y
      end

      def to_tree
        super.merge(
          content: @content,
          horizontal_alignment: @horizontal_alignment,
          vertical_alignment: @vertical_alignment,
          font_size: @font_size,
          size_when_fit: size_when_fit
        )
      end

      private

      def text_primitive
        @text_primitive ||= Ruby2D::Text.new content, size: font_size
      end
    end
  end
end
