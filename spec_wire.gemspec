# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{spec_wire}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ed Howland"]
  s.date = %q{2009-12-28}
  s.description = %q{spec_wire_desc}
  s.email = %q{ed.howland@gmail.com}
  s.extra_rdoc_files = [
    "ChangeLog",
     "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "ChangeLog",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "config/environment.rb",
     "cookie.rb",
     "features/spec_wire.feature",
     "features/step_definitions/spec_on_steps.rb",
     "features/support/env.rb",
     "lib/const.rb",
     "lib/initializer.rb",
     "lib/spec_wire.rb",
     "run.rb",
     "servers/.gitignore",
     "servers/app.rb",
     "servers/bar.php",
     "servers/config.ru",
     "servers/lib/limonade.php",
     "servers/obj_rest.rb",
     "servers/ruby_server.rb",
     "servers/server.php",
     "servers/session.rb",
     "servers/sinatra.log",
     "spec/.gitignore",
     "spec/initializer_spec.rb",
     "spec/simple_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/spec_wire_spec.rb",
     "spec_wire.gemspec",
     "tmp/class_cache/bar.rb"
  ]
  s.homepage = %q{http://github.com/edhowland/spec_wire}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{spec_wire}
  s.test_files = [
    "spec/initializer_spec.rb",
     "spec/simple_spec.rb",
     "spec/spec_helper.rb",
     "spec/spec_wire_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<json>, [">= 0"])
      s.add_development_dependency(%q<rest-client>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<rest-client, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<rest-client, [">= 0"])
  end
end

