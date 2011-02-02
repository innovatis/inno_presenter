# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "inno_presenter/version"

Gem::Specification.new do |s|
  s.name        = "inno_presenter"
  s.version     = InnoPresenter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Burke Libbey"]
  s.email       = ["burke@burkelibbey.org"]
  s.homepage    = ""
  s.summary     = %q{Presenters are presenters}
  s.description = %q{Presenters are presenters}

  s.add_dependency "action_pack"
  s.add_dependency "filterriffic"
  
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
