# frozen_string_literal: true
require 'json'

module Interact
  module Components
    class Row < Container
      include ::Interact::DSL::Gap
      include ::Interact::DSL::Row
      include ::Interact::DSL::Column
      include ::Interact::DSL::Button

      def size_when_fit(&block)
        @size_when_fit ||= (
          widths, heights = children
                              .select { |child| block.nil? or block.call(child) }
                              .map(&:size_when_fit)
                              .transpose
                              .then { |sizes| sizes == [] ? [[], [0]] : sizes }
          [
            padding.west + widths.sum + gap_sum + padding.east,
            padding.north + heights.max + padding.south
          ]
        )
      end

      def build(x:, y:, width:, height:)
        super

        min_width = min_width()
        min_height = min_height()

        remaining_width = width - min_width
        raise_missing_space(min_width) if remaining_width < 0.0
        remaining_height = height - min_height
        raise_missing_space(min_height, axis: :vertical, available_space: height) if remaining_height < 0.0

        expanding_children_count = expanding_children_count()
        expand_width = expanding_children_count.nonzero? && (remaining_width / expanding_children_count)
        remaining_width -= expanding_children_count * expand_width if expand_width

        start_x = padding.east
        start_y = padding.north
        if alignment == :center
          start_x += remaining_width / 2.0
        elsif alignment == :end
          start_x += remaining_width
        end

        build_children start_x, start_y, expand_width, height - (padding.north + padding.south)
      end

      private

      def build_children(start_x, start_y, expand_width, expand_height)
        current_x = start_x
        children.each do |child|
          case child.alignment_in_container
          when :start
            start_y
          when :center
            expand_height - start_y
          end

          current_x += build_child(child, current_x, start_y, expand_width, expand_height) { |_, child_height|
            y_offset = offset_for_alignment child.alignment_in_container, expand_height, child_height
            { y: start_y + y_offset }
          }[0]
          current_x += gap_between_children
        end
      end

      def expanding_children_count
        children.count(&method(:desired_child_width))
      end

      def min_width
        [
          (size_when_fit { |child| desired_child_width(child) == :fit })[0],
          children
            .select { |child| desired_child_width(child).is_a? Numeric }
            .map(&method(:desired_child_width))
            .sum
        ].sum
      end

      def min_height
        [
          size_when_fit[1],
          (children.select { |child| child.desired_height.is_a? Numeric }.map(&:desired_height).max || 0)
        ].max
      end

      def raise_missing_space(required_space, axis: :horizontal, component: nil, available_space: width)
        raise NotEnoughSpaceError.new(
          axis: axis,
          parent_component: self,
          component: component,
          required_space: required_space,
          available_space: available_space
        )
      end
    end
  end
end
