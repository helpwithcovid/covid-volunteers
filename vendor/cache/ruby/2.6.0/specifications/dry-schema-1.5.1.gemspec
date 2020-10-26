# -*- encoding: utf-8 -*-
# stub: dry-schema 1.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "dry-schema".freeze
  s.version = "1.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "https://rubygems.org", "bug_tracker_uri" => "https://github.com/dry-rb/dry-schema/issues", "changelog_uri" => "https://github.com/dry-rb/dry-schema/blob/master/CHANGELOG.md", "source_code_uri" => "https://github.com/dry-rb/dry-schema" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Piotr Solnica".freeze]
  s.date = "2020-05-21"
  s.description = "dry-schema provides a DSL for defining schemas with keys and rules that should be applied to\nvalues. It supports coercion, input sanitization, custom types and localized error messages\n(with or without I18n gem). It's also used as the schema engine in dry-validation.\n".freeze
  s.email = ["piotr.solnica@gmail.com".freeze]
  s.homepage = "https://dry-rb.org/gems/dry-schema".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.4.0".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Coercion and validation for data structures".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<dry-configurable>.freeze, ["~> 0.8", ">= 0.8.3"])
    s.add_runtime_dependency(%q<dry-core>.freeze, ["~> 0.4"])
    s.add_runtime_dependency(%q<dry-equalizer>.freeze, ["~> 0.2"])
    s.add_runtime_dependency(%q<dry-initializer>.freeze, ["~> 3.0"])
    s.add_runtime_dependency(%q<dry-logic>.freeze, ["~> 1.0"])
    s.add_runtime_dependency(%q<dry-types>.freeze, ["~> 1.4"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
  else
    s.add_dependency(%q<concurrent-ruby>.freeze, ["~> 1.0"])
    s.add_dependency(%q<dry-configurable>.freeze, ["~> 0.8", ">= 0.8.3"])
    s.add_dependency(%q<dry-core>.freeze, ["~> 0.4"])
    s.add_dependency(%q<dry-equalizer>.freeze, ["~> 0.2"])
    s.add_dependency(%q<dry-initializer>.freeze, ["~> 3.0"])
    s.add_dependency(%q<dry-logic>.freeze, ["~> 1.0"])
    s.add_dependency(%q<dry-types>.freeze, ["~> 1.4"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
