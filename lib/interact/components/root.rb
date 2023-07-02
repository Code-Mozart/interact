# frozen_string_literal: true

module Interact
  module Components
    class Root < Component
      include ::Interact::DSL::Row

      attr_accessor :child

      def initialize
        super(parent: nil, width: :expand, height: :expand)
      end

      def build
        child.build x: 0, y: 0, width: Window.width, height: Window.height
      end

      def to_tree(**options)
        super(**options).merge(
          child: child.to_tree(inherited_desired_width: :expand, inherited_desired_height: :expand)
        )
      end

      def children
        Struct.new(:root) {
          def <<(arg)
            root.child = arg
          end
        }.new(self)
      end
    end
  end
end
