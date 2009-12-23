module SpecWire
  class Initializer
    attr_accessor :server_url, :session_key
    @@config = self.new
    @@config.server_url = 'http://localhost:4567'
    @@config.session_key = 'rack.session'
    def initialize()
      @server_url = 'http://localhost:4567' # ruby server
      @session_key = 'rack.session'
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
