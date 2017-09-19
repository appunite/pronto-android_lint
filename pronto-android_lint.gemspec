# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "pronto/android_lint/version"

Gem::Specification.new do |spec|
  spec.name          = "pronto-android_lint"
  spec.version       = Pronto::AndroidLint::VERSION
  spec.authors       = ["Tobiasz Małecki"]
  spec.email         = ["tobiasz.malecki@appunite.com"]
  spec.homepage      = "https://git.appunite.com/tobiasz/pronto-android"

  spec.summary       = "Pronto runner for android lint"
  spec.license       = "MIT"

  spec.files         = Dir.glob("lib/**/*")
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency "pronto", "~> 0.7"
  spec.add_runtime_dependency "nokogiri", "~> 1.5"
end
