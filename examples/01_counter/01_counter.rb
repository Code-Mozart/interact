require 'bundler'
Bundler.require(:default)

Interact::Application.new(
  theme: Interact::Themes.light,
  title: '01 Counter'
) do
  row do
    button text: 'Click me'
  end
end
