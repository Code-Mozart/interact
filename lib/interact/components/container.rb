# frozen_string_literal: true

module Interact
  module Components
    class Container < Component
      attr_reader :children, :default_child_width, :default_child_height, :alignment, :gap_between_children

      def initialize(**options)
        super

        options = parse_options(
          options,
          :default_child_width, :default_child_height, :alignment, :gap_between_children
        )

        @children = []
        @default_child_width = options.default_child_width
        @default_child_height = options.default_child_height
        @alignment = options.alignment
        @gap_between_children = options.gap_between_children
      end

      def to_tree(**options)
        super(**options).merge(
          children: children.map { |child|
            child.to_tree inherited_desired_width: default_child_width,
                          inherited_desired_height: default_child_height
          },
          alignment: alignment,
          default_child_width: default_child_width,
          default_child_height: default_child_height,
          gap_between_children: gap_between_children,
          size_when_fit: size_when_fit
        )
      end

      def desired_child_width(child)
        child.desired_width == :inherit ? @default_child_width : child.desired_width
      end

      def desired_child_height(child)
        child.desired_height == :inherit ? @default_child_height : child.desired_height
      end

      protected

      def build_child(child, x, y, expand_width, expand_height, &_)
        case (desired_child_width = desired_child_width(child))
        when :fit
          child_width = child.size_when_fit[0]
        when :expand
          child_width = expand_width
        when Numeric
          child_width = [desired_child_width, expand_width].min
        else
          raise ArgumentError, "Desired width of '#{desired_child_width}' not supported"
        end

        case (desired_child_height = desired_child_height(child))
        when :fit
          child_height = child.size_when_fit[1]
        when :expand
          child_height = expand_height
        when Numeric
          child_height = [desired_child_height, expand_height].min
        else
          raise ArgumentError, "Desired height of '#{desired_child_height}' not supported"
        end

        build_options = { x: x, y: y, width: child_width, height: child_height }
        build_options.merge! yield(child_width, child_height) if block_given?
        child.build **build_options
        [child_width, child_height]
      end

      def gap_sum
        (children.count - 1) * gap_between_children
      end

      def validate_options(options)
        super
        ensure_valid_alignment options.alignment, :alignment
        ensure_enum_or_numeric options.default_child_width, :default_child_width, [:fit, :expand]
        ensure_enum_or_numeric options.default_child_height, :default_child_height, [:fit, :expand]
      end
    end
  end
end
