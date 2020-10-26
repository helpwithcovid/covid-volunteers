# -*- encoding: utf-8 -*-
# stub: rails-controller-testing 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "rails-controller-testing".freeze
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Rails Core Team".freeze]
  s.date = "2018-12-05"
  s.homepage = "https://github.com/rails/rails-controller-testing".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.2".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Extracting `assigns` and `assert_template` from ActionDispatch.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<actionpack>.freeze, [">= 5.0.1.x"])
    s.add_runtime_dependency(%q<actionview>.freeze, [">= 5.0.1.x"])
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.0.1.x"])
    s.add_development_dependency(%q<railties>.freeze, ["> 5.0.1.x"])
    s.add_development_dependency(%q<sqlite3>.freeze, [">= 0"])
  else
    s.add_dependency(%q<actionpack>.freeze, [">= 5.0.1.x"])
    s.add_dependency(%q<actionview>.freeze, [">= 5.0.1.x"])
    s.add_dependency(%q<activesupport>.freeze, [">= 5.0.1.x"])
    s.add_dependency(%q<railties>.freeze, ["> 5.0.1.x"])
    s.add_dependency(%q<sqlite3>.freeze, [">= 0"])
  end
end
