# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "backboneAX/version"

Gem::Specification.new do |s|
  s.name        = "backboneAX"
  s.version     = BackboneAX::VERSION
  s.authors     = ["Chris Douglas"]
  s.email       = ["dougo.chris@gmail.com"]
  s.homepage    = "https://github.com/dougochris/backboneAX"
  s.summary     = %q{backbone Application Extensions}
  s.description = %q{backbone Application Extensions for cleaner application development}

  s.rubyforge_project = "backboneAX"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
