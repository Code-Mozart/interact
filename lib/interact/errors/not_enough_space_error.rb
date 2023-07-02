# frozen_string_literal: true

module Interact
  module Errors
    class NotEnoughSpaceError < UIDefinitionError
      attr_reader :parent_component, :component, :required_space, :available_space

      def initialize(msg = nil, axis:, parent_component:, component:, required_space:, available_space:)
        axis_options = [:horizontal, :vertical]
        raise ArgumentError, "must be one of #{axis_options}" unless axis&.in?(axis_options)

        @axis = axis
        @parent_component = parent_component
        @component = component
        @required_space = required_space
        @available_space = available_space

        super "There is not enough space on the #{axis} axis to place the "\
              "#{component ? "component #{component}" : 'components'} "\
              "within the parent #{parent_component}. It requires #{required_space} units but "\
              "only #{available_space} units are available so it is missing "\
              "#{required_space - available_space} units#{msg ? ": #{msg}" : '.'}"
      end
    end
  end
end
