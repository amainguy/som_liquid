# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'som/liquid/version'

Gem::Specification.new do |spec|
  spec.name          = "som_liquid"
  spec.version       = Som::Liquid::VERSION
  spec.authors       = ["amainguy"]
  spec.email         = ["amainguy@gmail.com"]

  spec.description   = %q{Overrides or add functionalities to locomotive_liquid gem}
  spec.summary       = %q{Custom liquid elements}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_path  = 'lib'
  spec.files         = Dir.glob('lib/**/*')

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'locomotivecms_steam', '~> 1.0.0.rc2'

end
