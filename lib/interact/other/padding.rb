# frozen_string_literal: true

module Interact
  class Padding
    include ::Interact::Helpers::OptionHelpers

    attr_reader :north, :east, :south, :west

    def initialize(option)
      validate_option option
      parse option
    end

    def to_tree
      {
        north: north,
        east: east,
        south: south,
        west: west
      }
    end

    private

    def parse(option)
      if option.is_a? Numeric
        set option, :north, :east, :south, :west
        return
      end

      horizontal = option[:horizontal]
      set horizontal, :east, :west if horizontal

      vertical = option[:vertical]
      set vertical, :east, :west if vertical

      [:north, :east, :south, :west].each { |side| set option[side], side if option[side] }
    end

    def set(value, *sides)
      sides.each { |side| instance_variable_set "@#{side}", value }
    end

    def validate_option(option)
      if option.is_a? Hash
        ensure_hash_schema(
          option, 'padding',
          { horizontal: Numeric, vertical: Numeric },
          { horizontal: Numeric, north: Numeric, south: Numeric },
          { west: Numeric, east: Numeric, vertical: Numeric },
          { west: Numeric, east: Numeric, north: Numeric, south: Numeric },
          allow_missing_keys: true
        )
      else
        ensure_numeric option, 'padding'
      end
    end
  end
end
