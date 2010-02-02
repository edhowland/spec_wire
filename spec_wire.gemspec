# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{spec_wire}
  s.version = "0.3.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ed Howland"]
  s.date = %q{2010-02-02}
  s.description = %q{spec_wire_desc}
  s.email = %q{ed.howland@gmail.com}
  s.executables = ["server.start", "server.stop", "spec_wire"]
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
     "bin/server.start",
     "bin/server.stop",
     "bin/spec_wire",
     "config/environment.rb",
     "doc/notes.txt",
     "features/spec_wire.feature",
     "features/step_definitions/spec_on_steps.rb",
     "features/support/env.rb",
     "lib/spec_wire.rb",
     "lib/spec_wire/class_proxy.rb",
     "lib/spec_wire/const.rb",
     "lib/spec_wire/exceptions.rb",
     "lib/spec_wire/initializer.rb",
     "run.rb",
     "servers/.gitignore",
     "servers/Foo.php",
     "servers/app.rb",
     "servers/bar.php",
     "servers/bar.rb",
     "servers/config.ru",
     "servers/foo_baz.rb",
     "servers/lib/limonade.php",
     "servers/myfoo.php",
     "servers/myfoo.rb",
     "servers/obj_rest.rb",
     "servers/ruby_server.rb",
     "servers/server.php",
     "servers/session.rb",
     "servers/sinatra.log",
     "servers/support/env.php",
     "servers/support/env.rb",
     "spec/.gitignore",
     "spec/blank_spec.rb",
     "spec/curl_tests/curl_class",
     "spec/curl_tests/curl_class_php",
     "spec/curl_tests/curl_class_ruby",
     "spec/curl_tests/curl_msg_php",
     "spec/curl_tests/curl_msg_ruby",
     "spec/curl_tests/parse_id.rb",
     "spec/curl_tests/php_server_path",
     "spec/curl_tests/ruby_server_path",
     "spec/curl_tests/server_path",
     "spec/error_spec.rb",
     "spec/exist_spec.rb",
     "spec/initializer_spec.rb",
     "spec/modify_spec.rb",
     "spec/myfoo_spec.rb",
     "spec/simple_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb",
     "spec/spec_wire_spec.rb",
     "spec/support/matchers/blank.rb",
     "spec/support/matchers/exist.rb",
     "spec/support_spec.rb",
     "spec_wire.gemspec",
     "templates/php/spec/server/lib/limonade.php",
     "templates/php/spec/server/server.php",
     "templates/php/spec/server/support/env.php",
     "templates/php/spec/spec_helper.rb",
     "templates/php/spec/support/matchers/blank.rb",
     "templates/php/spec/support/matchers/exist.rb",
     "templates/ruby/spec/bin/server.start",
     "templates/ruby/spec/bin/server.stop",
     "templates/ruby/spec/server/ruby_server.rb",
     "templates/ruby/spec/server/support/env.rb",
     "templates/ruby/spec/spec_helper.rb",
     "templates/ruby/spec/support/matchers/blank.rb",
     "templates/ruby/spec/support/matchers/exist.rb"
  ]
  s.homepage = %q{http://github.com/edhowland/spec_wire}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{spec_wire}
  s.test_files = [
    "spec/blank_spec.rb",
     "spec/curl_tests/parse_id.rb",
     "spec/error_spec.rb",
     "spec/exist_spec.rb",
     "spec/initializer_spec.rb",
     "spec/modify_spec.rb",
     "spec/myfoo_spec.rb",
     "spec/simple_spec.rb",
     "spec/spec_helper.rb",
     "spec/spec_wire_spec.rb",
     "spec/support/matchers/blank.rb",
     "spec/support/matchers/exist.rb",
     "spec/support_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<cucumber>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 1.2.0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 1.2.0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0.9.4"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<json>, [">= 1.2.0"])
      s.add_dependency(%q<rest-client>, [">= 1.2.0"])
      s.add_dependency(%q<sinatra>, [">= 0.9.4"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<json>, [">= 1.2.0"])
    s.add_dependency(%q<rest-client>, [">= 1.2.0"])
    s.add_dependency(%q<sinatra>, [">= 0.9.4"])
  end
end

