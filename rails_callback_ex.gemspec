# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rails_callback_ex/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_callback_ex"
  spec.version       = RailsCallbackEx::VERSION
  spec.authors       = ["Yoshikazu Kaneta"]
  spec.email         = ["kaneta@sitebridge.co.jp"]
  spec.summary       = %q{Insert/delete callbacks for rails.}
  spec.description   = %q{Insert/delete callbacks for rails.}
  spec.homepage      = "https://github.com/kanety/rails_callback_ex"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 6.1"

  spec.add_development_dependency "rspec-rails"
  spec.add_development_dependency "simplecov"
end
