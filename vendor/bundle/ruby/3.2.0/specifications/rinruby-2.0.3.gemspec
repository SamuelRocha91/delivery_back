# -*- encoding: utf-8 -*-
# stub: rinruby 2.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rinruby".freeze
  s.version = "2.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Dahl".freeze, "Claudio Bustos".freeze]
  s.date = "2012-07-31"
  s.description = "RinRuby is a Ruby library that integrates the R interpreter in Ruby, making R's statistical routines and graphics available within Ruby.  The library consists of a single Ruby script that is simple to install and does not require any special compilation or installation of R.  Since the library is 100% pure Ruby, it works on a variety of operating systems, Ruby implementations, and versions of R.  RinRuby's methods are simple, making for readable code.  The {website [rinruby.ddahl.org]}[http://rinruby.ddahl.org] describes RinRuby usage, provides comprehensive documentation, gives several examples, and discusses RinRuby's implementation.\n\n\nCopyright 2005-2008 David B. Dahl\n\nDeveloped by David B. Dahl\nDocumented by David B. Dahl and Scott Crawford\nHomepage: http://rinruby.ddahl.org\n\nContributors: Claudio Bustos".freeze
  s.email = ["rinruby_AT_ddahl.org".freeze, "clbustos_AT_gmail.com".freeze]
  s.extra_rdoc_files = ["History.txt".freeze, "LICENSE.txt".freeze, "Manifest.txt".freeze, "README.txt".freeze]
  s.files = ["History.txt".freeze, "LICENSE.txt".freeze, "Manifest.txt".freeze, "README.txt".freeze]
  s.homepage = "http://rinruby.ddahl.org/".freeze
  s.rdoc_options = ["--main".freeze, "README.txt".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "RinRuby is a Ruby library that integrates the R interpreter in Ruby, making R's statistical routines and graphics available within Ruby".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 3

  s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.10"])
  s.add_development_dependency(%q<hoe>.freeze, ["~> 3.0"])
end
