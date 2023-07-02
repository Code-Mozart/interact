# frozen_string_literal: true

module Interact
  module Components
    class Component
      include ::Interact::Helpers::OptionHelpers
      include ::Interact::Errors

      attr_reader :parent, :desired_width, :desired_height, :alignment_in_container, :padding
      attr_reader :x, :y, :width, :height

      def initialize(**options)
        options = parse_options(
          options,
          :parent,
          width: :fit, height: :fit, alignment_in_container: :center, padding: 5
        )
        validate_options options

        @parent = options.parent
        @desired_width = options.width
        @desired_height = options.height
        @alignment_in_container = options.alignment_in_container
        @padding = Padding.new options.padding
      end

      def build(x:, y:, width:, height:)
        @x = x
        @y = y
        @width = width
        @height = height
      end

      def to_tree(inherited_desired_width: nil, inherited_desired_height: nil)
        {
          component: self.class.name,
          desired_width: @desired_width == :inherit ? "#{inherited_desired_width} (inherited)" : @desired_width,
          desired_height: @desired_height == :inherit ? "#{inherited_desired_height} (inherited)" : @desired_height,
          alignment_in_container: @alignment_in_container,
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
        validate_alignment_in_container options
      end

      def validate_desired_size(options)
        [:width, :height].each do |dimension_option|
          opt = options.send dimension_option
          name = dimension_option
          ensure_enum_or_numeric opt, name, [:inherit, :fit, :expand]
        end
      end

      def validate_alignment_in_container(options)
        ensure_valid_alignment options.alignment_in_container, :alignment_in_container
      end

      def ensure_valid_alignment(opt, name)
        ensure_enum opt, name, [:start, :center, :end]
      end

      def offset_for_alignment(alignment, available_space, required_space)
        case alignment
        when :start
          0
        when :center
          (available_space / 2) - (required_space / 2)
        when :end
          available_space - required_space
        end
      end
    end
  end
end
