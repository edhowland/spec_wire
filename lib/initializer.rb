module SpecWire
  class Initializer
    attr_accessor :server_url
    @@config = self.new
    @@config.server_url = 'http://localhost:4567'
    def initialize()
      @server_url = 'http://localhost:4567' # ruby server
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
