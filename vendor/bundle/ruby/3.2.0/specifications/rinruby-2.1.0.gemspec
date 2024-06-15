# -*- encoding: utf-8 -*-
# stub: rinruby 2.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "rinruby".freeze
  s.version = "2.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["David Dahl".freeze, "Scott Crawford".freeze, "Claudio Bustos".freeze]
  s.date = "2018-08-19"
  s.description = "RinRuby is a Ruby library that integrates the R interpreter in Ruby, making R's statistical routines and graphics available within Ruby. The library consists of a single Ruby script that is simple to install and does not require any special compilation or installation of R. Since the library is 100% pure Ruby, it works on a variety of operating systems, Ruby implementations, and versions of R.  RinRuby's methods are simple, making for readable code.  The {website [rinruby.ddahl.org]}[http://rinruby.ddahl.org] describes RinRuby usage, provides comprehensive documentation, gives several examples, and discusses RinRuby's implementation.".freeze
  s.email = ["rinruby@ddahl.org".freeze, "scott@ddahl.org".freeze, "clbustos@gmail.com".freeze]
  s.homepage = "http://rinruby.ddahl.org".freeze
  s.licenses = ["Copyright 2005-2008 David B. Dahl".freeze]
  s.rubygems_version = "3.4.10".freeze
  s.summary = "RinRuby is a Ruby library that integrates the R interpreter in Ruby".freeze

  s.installed_by_version = "3.4.10" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_development_dependency(%q<rake>.freeze, [">= 0"])
  s.add_development_dependency(%q<rspec>.freeze, [">= 2.11"])
  s.add_development_dependency(%q<hoe>.freeze, [">= 0"])
end
