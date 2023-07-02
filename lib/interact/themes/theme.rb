# frozen_string_literal: true

module Interact
  module Themes
    class Theme
      attr_accessor :name, :parent_theme

      def initialize(name:, parent: nil, &block)
        @name = name
        @parent_theme = parent
      end
    end
  end
end
