# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'landlady/version'

Gem::Specification.new do |spec|
  spec.name          = "landlady"
  spec.version       = Landlady::VERSION
  spec.authors       = ["Kym McInerney"]
  spec.email         = ["kym@holodigm.com.au"]
  spec.description   = %q{Using a subdomain mapping design pattern, Landlady takes advantage of PostgresQL SCHEMA_SEARCH_PATH and using naming conventions will map tenants with complete data segregation to the required data namespace.}
  spec.summary       = %q{Super simple postgres multitenancy}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
