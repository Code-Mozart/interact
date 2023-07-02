# frozen_string_literal: true

require 'ruby2d'

module Interact
  class Application
    include ::Ruby2D::DSL

    attr_reader :width, :height, :resizable, :title, :theme

    def initialize(
      width: 800,
      height: 600,
      resizable: true,
      title: nil,
      theme: ::Interact::Themes.light,
      &block
    )
      @width = width
      @height = height
      @resizable = resizable
      @title = title || (
        p('[INTERACT] you can set the title of your application with the :title option')
        'Interact Application'
      )
      @theme = theme

      ::Ruby2D::DSL.window = ::Ruby2D::Window.new(title: title, width: width, height: height)
      self.set(resizable: resizable, background: '#888888')

      @root = ::Interact::Components::Root.new
      @root.instance_eval &block
      @root.build
      puts JSON.pretty_generate @root.to_tree

      self.show
    end
  end
end
