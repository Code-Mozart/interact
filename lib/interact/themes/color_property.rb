# frozen_string_literal: true

require 'ruby2d'

module Interact
  module Themes
    class ColorProperty
      attr_accessor :color, :parent

      def initialize(color: nil, parent: nil)
        raise ArgumentError, 'must be a Ruby2D color' unless color.is_a? Ruby2D::Color
        raise ArgumentError, 'must be a color property' unless parent.is_a? ColorProperty

        @color = color
        @parent = parent
      end
    end
  end
end
