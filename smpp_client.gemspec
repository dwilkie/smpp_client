# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smpp_client/version'

Gem::Specification.new do |spec|
  spec.name          = "smpp_client"
  spec.version       = SmppClient::VERSION
  spec.authors       = ["David Wilkie"]
  spec.email         = ["dwilkie@gmail.com"]
  spec.description   = "A SMPP client written in Ruby that can connect to SMSCs for sending and receiving  SMS messages"
  spec.summary       = "A SMPP client implemented in Ruby"
  spec.homepage      = "https://github.com/dwilkie/ruby_smpp_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "pace"
  spec.add_dependency "ruby-smpp"
  spec.add_dependency "resque"
  spec.add_dependency "thor"

  spec.add_development_dependency "foreman"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "fakefs"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
