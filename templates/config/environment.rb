# environment.rb
# included from spec/spec_helper.rb

SpecWire::Initializer.run do |config|
  config.class_cache = File.join(File.expand_path(File.dirname(__FILE__)), '..', 'tmp', 'class_cache')
end


