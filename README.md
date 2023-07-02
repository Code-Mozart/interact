# Interact

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

Interact is a versatile UI Framework for Ruby2D, designed to simplify the process of building dynamic and interactive user interfaces. It is currently in the early stages of development and has not been released yet. You are invited to participate and contribute to its development.

## Features

- Intuitive DSL for effortless UI construction
- Component-based architecture for flexible and scalable designs
- CSS-like theming system for easy customization

## Getting Started

### Prerequisites

- Ruby2D library
- Other dependencies (list any additional dependencies)

### Installation

Interact is currently not hosted on Rubygems so you have to clone it from GitHub instead like so:
```ruby
# Gemfile

gem 'interact', git: 'https://github.com/Code-Mozart/interact'
```

## Usage

```ruby
require './src/ui/interact'

def build_ui
  ::Interact::GUI.new(
    theme: ::Interact::Themes.light
  ) do
    button text: 'Click me'
    # Define your UI components here
  end
end
```

## Contributing
Contributions are welcome! Please report any bugs or problems in an _[Issue](https://github.com/Code-Mozart/interact/issues/new)_. To contribute to the codebase please open a _Pull Request_.

## License
Interact is released under the MIT License. See the `LICENSE.txt` file for more information.

## Contact
For any inquiries or feedback, please contact Codemozart at thecodemozart@gmail.com.
