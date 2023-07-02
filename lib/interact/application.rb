# frozen_string_literal: true

module Interact
  class Application
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

      require 'ruby2d'

      set width: width, height: height, resizable: resizable, title: title, background: '#F8F8F8'

      @root = ::Interact::Components::Root.new
      @root.instance_eval &block
      @root.build

      show
    end
  end
end
