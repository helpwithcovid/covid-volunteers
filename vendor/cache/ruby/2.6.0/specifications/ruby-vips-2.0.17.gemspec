# -*- encoding: utf-8 -*-
# stub: ruby-vips 2.0.17 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby-vips".freeze
  s.version = "2.0.17"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "msys2_mingw_dependencies" => "libvips" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["John Cupitt".freeze]
  s.date = "2020-01-07"
  s.description = "ruby-vips is a binding for the vips image processing library. It is fast and it can process large images without loading the whole image in memory.".freeze
  s.email = "jcupitt@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.md".freeze, "TODO".freeze]
  s.files = ["LICENSE.txt".freeze, "README.md".freeze, "TODO".freeze]
  s.homepage = "http://github.com/libvips/ruby-vips".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.4".freeze
  s.summary = "Ruby extension for the vips image processing library.".freeze

  s.installed_by_version = "3.1.4" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<ffi>.freeze, ["~> 1.9"])
    s.add_development_dependency(%q<rake>.freeze, ["~> 11.0"])
    s.add_development_dependency(%q<rspec>.freeze, ["~> 3.3"])
    s.add_development_dependency(%q<yard>.freeze, ["~> 0.9.11"])
    s.add_development_dependency(%q<redcarpet>.freeze, ["~> 3.3"])
    s.add_development_dependency(%q<github-markup>.freeze, ["~> 1.4"])
    s.add_development_dependency(%q<bundler>.freeze, [">= 1.0", "< 3"])
    s.add_development_dependency(%q<rubocop>.freeze, ["~> 0.64"])
  else
    s.add_dependency(%q<ffi>.freeze, ["~> 1.9"])
    s.add_dependency(%q<rake>.freeze, ["~> 11.0"])
    s.add_dependency(%q<rspec>.freeze, ["~> 3.3"])
    s.add_dependency(%q<yard>.freeze, ["~> 0.9.11"])
    s.add_dependency(%q<redcarpet>.freeze, ["~> 3.3"])
    s.add_dependency(%q<github-markup>.freeze, ["~> 1.4"])
    s.add_dependency(%q<bundler>.freeze, [">= 1.0", "< 3"])
    s.add_dependency(%q<rubocop>.freeze, ["~> 0.64"])
  end
end
