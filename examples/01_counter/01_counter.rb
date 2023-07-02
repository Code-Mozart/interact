require 'bundler'
Bundler.require(:default)

Interact::Application.new(
  theme: Interact::Themes.light,
  title: '01 Counter'
) do
  row do
    button 'Click me'
  end
end
