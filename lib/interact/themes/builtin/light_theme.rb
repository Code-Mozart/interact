# frozen_string_literal: true

module Interact
  module Themes
    def self.light
      Theme.new(name: 'light', parent: Themes.default) do
        font_color = 'navy'
        background_color = '#F6F6F6'
      end
    rescue
      # TODO: remove when themes are implemented
      # ignored
    end
  end
end
