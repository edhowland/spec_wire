class Module
  
  def server_url
    SpecWire::Initializer.config.server_url
  end
  def session_key
    SpecWire::Initializer.config.session_key
  end
  
  def const_missing(name)
    class_cache = File.join(File.expand_path(File.dirname(__FILE__)), '..', 'tmp', 'class_cache')
    fname=name.to_s.downcase
    class_path=File.join(class_cache, "#{fname}.rb")
    File.open(class_path, 'w+') do |f|
      puts "creating #{class_path}"
      f.puts <<-EOC
        require 'json'
        require 'rest_client'
        require 'cgi'
        class #{name}
          def initialize(*args)
            resp = RestClient.post('#{server_url}/class/#{name}', :args => JSON.generate(args))
            @meta = JSON.parse(resp)
            @our_id = @meta['id']
            @session_cookies = resp.cookies
          end
          attr_reader :our_id, :session_cookies, :meta
          def self.method_missing(method_name, *args)
            JSON.parse(RestClient.get('#{server_url}/class/#{name}/msg/' + method_name + '/args/' + CGI.escape(JSON.generate(args))))[0]
          end
          def method_missing(name, *args)
            JSON.parse(RestClient.put('#{server_url}/object/' + @our_id.to_s + '/msg/' + name, 
              {:args => JSON.generate(args)}, {:cookies => @session_cookies}))[0]
          end
        end
      EOC
    end unless File.exists?(class_path)
    require class_path
    klass = const_get(name)
    return klass if klass
    raise "Class not found: #{name}"    
  end
end