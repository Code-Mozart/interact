# frozen_string_literal: true

require_relative 'lib/interact/version'

Gem::Specification.new do |spec|
  spec.name = 'Interact'
  spec.version = Interact::VERSION
  spec.authors = ['Codemozart']
  spec.email = ['thecodemozart@gmail.com']

  spec.summary = 'Interact is a Ruby2D UI Framework that enables effortless construction of dynamic interfaces using an intuitive DSL and CSS-like theming.'
  spec.description = "'Interact is a versatile UI Framework for Ruby2D that empowers developers to effortlessly create robust and engaging user interfaces. With its intuitive DSL and component-based architecture, building custom UIs becomes seamless. Customize and style components effortlessly using a CSS-like theming system. From simple to complex UI structures, Interact provides flexibility and ease of use. Elevate your application's user experience with the powerful features of Interact.'"
  spec.homepage = 'https://github.com/Code-Mozart/interact'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Code-Mozart/interact'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor Gemfile])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  spec.add_dependency 'ruby2d'

  spec.add_development_dependency 'rspec', '~> 3.0'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
