Gem::Specification.new do |spec|
  spec.name          = 'lita-netping'
  spec.version       = '0.5.0'
  spec.authors       = ['Eric Sigler']
  spec.email         = ['me@esigler.com']
  spec.description   = 'An IP ping plugin for Lita'
  spec.summary       = 'An IP ping plugin for Lita'
  spec.homepage      = 'https://github.com/esigler/lita-netping'
  spec.license       = 'MIT'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '>= 4.0'
  spec.add_runtime_dependency 'net-ping'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'
end
