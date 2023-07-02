# frozen_string_literal: true

module Interact
  def self.dir = ::File.expand_path('interact', __dir__)

  autoload :VERSION, "#{Interact.dir}/version"

  autoload :GUI, "#{Interact.dir}/gui"

  module Components
    autoload :Component, "#{Interact.dir}/components/component"
    autoload :Root, "#{Interact.dir}/components/root"
    autoload :Container, "#{Interact.dir}/components/container"
    autoload :Row, "#{Interact.dir}/components/row"
    autoload :Column, "#{Interact.dir}/components/column"
    autoload :Gap, "#{Interact.dir}/components/gap"
    autoload :Text, "#{Interact.dir}/components/text"
    autoload :Button, "#{Interact.dir}/components/button"
  end

  module DSL
    autoload :Row, "#{Interact.dir}/dsl/row"
    autoload :Column, "#{Interact.dir}/dsl/column"
    autoload :Gap, "#{Interact.dir}/dsl/gap"
    autoload :Button, "#{Interact.dir}/dsl/button"
  end

  module Errors
    autoload :UIDefinitionError, "#{Interact.dir}/errors/ui_definition_error"
  end

  module Helpers
    autoload :OptionHelpers, "#{Interact.dir}/helpers/option_helpers"
  end

  module Themes
    autoload :Theme, "#{Interact.dir}/themes/theme"
    autoload :ColorProperty, "#{Interact.dir}/themes/color_property"
  end

  autoload :Padding, "#{Interact.dir}/other/padding"
end

require "#{Interact.dir}/themes/builtin/default_theme"
require "#{Interact.dir}/themes/builtin/light_theme"
