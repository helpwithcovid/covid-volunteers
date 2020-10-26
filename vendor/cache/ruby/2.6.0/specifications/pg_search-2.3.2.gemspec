# -*- encoding: utf-8 -*-
# stub: pg_search 2.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "pg_search".freeze
  s.version = "2.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Grant Hutchins".freeze, "Case Commons, LLC".freeze]
  s.date = "2020-01-13"
  s.description = "PgSearch builds Active Record named scopes that take advantage of PostgreSQL's full text search".freeze
  s.email = ["gems@nertzy.com".freeze, "casecommons-dev@googlegroups.com".freeze]
  s.homepage = "https://github.com/Casecommons/pg_search".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "PgSearch builds Active Record named scopes that take advantage of PostgreSQL's full text search".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<activerecord>.freeze, [">= 5.2"])
    s.add_runtime_dependency(%q<activesupport>.freeze, [">= 5.2"])
    s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 3.3"])
    s.add_development_dependency(%q<rubocop>.freeze, [">= 0.78.0"])
    s.add_development_dependency(%q<rubocop-performance>.freeze, [">= 0"])
    s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_development_dependency(%q<with_model>.freeze, [">= 1.2"])
  else
    s.add_dependency(%q<activerecord>.freeze, [">= 5.2"])
    s.add_dependency(%q<activesupport>.freeze, [">= 5.2"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 3.3"])
    s.add_dependency(%q<rubocop>.freeze, [">= 0.78.0"])
    s.add_dependency(%q<rubocop-performance>.freeze, [">= 0"])
    s.add_dependency(%q<simplecov>.freeze, [">= 0"])
    s.add_dependency(%q<with_model>.freeze, [">= 1.2"])
  end
end
