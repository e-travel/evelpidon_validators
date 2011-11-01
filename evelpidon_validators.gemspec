# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "evelpidon_validators/version"

Gem::Specification.new do |s|
  s.name        = "evelpidon_validators"
  s.version     = EvelpidonValidators::VERSION
  s.authors     = ["Nikos Dimitrakopoulos", "Eric Cohen"]
  s.email       = ["n.dimitrakopoulos@pamediakopes.gr", "e.koen@pamediakopes.gr"]
  s.homepage    = ""
  s.summary     = %q{Useful ActiveModel validators}
  s.description = %q{Useful ActiveModel validators with ClientSideValidations support.}

  s.rubyforge_project = "evelpidon_validators"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "activesupport"
  s.add_development_dependency "evelpidon_test_helpers"

  s.add_runtime_dependency "activemodel"
end
