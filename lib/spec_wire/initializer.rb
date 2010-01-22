module SpecWire
  class Initializer
    attr_accessor :server_url, :session_key, 
      :put_needs_method_arg, :class_cache
    @@config = self.new
    @@config.server_url = 'http://localhost:4567'
    @@config.session_key = 'rack.session'
    @@config.put_needs_method_arg = false
    @@config.class_cache = nil
    def initialize()
      @server_url = 'http://localhost:4567' # ruby server
      @session_key = 'rack.session'
      @put_needs_method_arg = false
      @class_cache = File.expand_path(File.dirname(__FILE__)) + '/../tmp/class_cache'
    end

    def self.run(&block)
      @@config = self.new
      yield @@config
    end
    def self.reset_to_defaults
      @@config = self.new
    end
    def self.config
      @@config
    end
    def self.config=(config)
      @@config = config
    end
  end
end
