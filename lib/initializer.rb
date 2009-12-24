module SpecWire
  class Initializer
    attr_accessor :server_url, :session_key, :put_needs_method_arg
    @@config = self.new
    @@config.server_url = 'http://localhost:4567'
    @@config.session_key = 'rack.session'
    @@config.put_needs_method_arg = false
    def initialize()
      @server_url = 'http://localhost:4567' # ruby server
      @session_key = 'rack.session'
      @put_needs_method_arg = false
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
  end
end
