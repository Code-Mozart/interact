# frozen_string_literal: true

module Interact
  module Themes
    def self.default
      Theme.new(name: 'default') do
        # disable for now
        break

        set_font family: Ruby2D::Font.default, size: 12
        set_padding 5
      end
    end
  end
end
