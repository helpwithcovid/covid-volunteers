# -*- encoding: utf-8 -*-
# stub: gibbon 3.3.3 ruby lib

Gem::Specification.new do |s|
  s.name = "gibbon".freeze
  s.version = "3.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Amro Mousa".freeze]
  s.date = "2020-02-07"
  s.description = "A wrapper for MailChimp API 3.0 and Export API".freeze
  s.email = ["amromousa@gmail.com".freeze]
  s.homepage = "http://github.com/amro/gibbon".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.8".freeze)
  s.rubygems_version = "3.1.4".freeze
  s.summary = "A wrapper for MailChimp API 3.0 and Export API".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<faraday>.freeze, [">= 0.16.0"])
    s.add_runtime_dependency(%q<multi_json>.freeze, [">= 1.11.0"])
    s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, ["= 3.5.0"])
    s.add_development_dependency(%q<webmock>.freeze, ["~> 1.21.0"])
  else
    s.add_dependency(%q<faraday>.freeze, [">= 0.16.0"])
    s.add_dependency(%q<multi_json>.freeze, [">= 1.11.0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, ["= 3.5.0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.21.0"])
  end
end
