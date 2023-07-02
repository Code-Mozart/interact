# frozen_string_literal: true

module Interact
  class GUI
    attr_reader :theme

    def initialize(
      theme: ::Interact::Themes.light,
      &block
    )
      @theme = theme

      @root = ::Interact::Components::Root.new
      @root.instance_eval &block
      @root.build
    end
  end
end
