# frozen_string_literal: true

module Interact
  module Components
    class Component
      include ::Interact::Helpers::OptionHelpers
      include ::Interact::Errors

      attr_reader :parent, :desired_width, :desired_height, :padding
      attr_reader :x, :y, :width, :height

      def initialize(**options)
        options = parse_options(
          options,
          :parent,
          width: :fit, height: :fit, padding: 5
        )
        validate_options options

        @parent = options.parent
        @desired_width = options.width
        @desired_height = options.height
        @padding = Padding.new options.padding
      end

      def build(x:, y:, width:, height:)
        @x = x
        @y = y
        @width = width
        @height = height
      end

      def to_tree
        {
          component: self.class.name,
          desired_width: @desired_width,
          desired_height: @desired_height,
          padding: @padding.to_tree,
          x: @x,
          y: @y,
          width: @width,
          height: @height
        }
      end

      protected

      def validate_options(options)
        validate_desired_size options
      end

      def validate_desired_size(options)
        [:width, :height].each do |dimension_option|
          opt = options.send dimension_option
          name = dimension_option
          ensure_enum_or_numeric opt, name, [:inherit, :fit, :expand]
        end
      end
    end
  end
end
