# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Appolo/version'

Gem::Specification.new do |spec|
  spec.name          = "appolo"
  spec.version       = Appolo::VERSION
  spec.authors       = ["Pedro Gabriel"]
  spec.email         = ["pedrogabriel@protonmail.ch"]

  spec.summary       = %q{Provides easy access to Thoth web API}
  spec.description   = %q{Ruby gem that provides quick and easy access to the web api of Thoth WebApp -
                        https://adeetc.thothapp.com/}
  spec.homepage      = "https://github.com/CaptainGabriel/AppoloGem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rest-client', '~> 1.8', '>= 1.8.0'
  spec.add_development_dependency 'json', '~> 1.8', '>= 1.8.3'
  #spec.add_development_dependency 'parallel', '~> 1.6.1'

end
