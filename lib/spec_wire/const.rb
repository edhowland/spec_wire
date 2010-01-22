class Module
  
  def server_url
    SpecWire::Initializer.config.server_url
  end
  def session_key
    SpecWire::Initializer.config.session_key
  end
  def put_needs_method_arg?
    SpecWire::Initializer.config.put_needs_method_arg
  end
  def class_cache
    SpecWire::Initializer.config.class_cache
  end
  
  def const_missing(name)
    fname=name.to_s.downcase
    class_path=File.join(class_cache, "#{fname}.rb")
    File.open(class_path, 'w+') do |f|
      puts "creating #{class_path}" # TODO remove
      f.puts <<-EOC
        require 'rubygems'
        require 'json'
        require 'rest_client'
        require 'cgi'
        class #{name}
          def initialize(*args)
            begin
              resp = RestClient.post('#{server_url}/class/#{name}', :args => JSON.generate(args))
              @meta = JSON.parse(resp)
              @our_id = @meta['id']
              @session_cookies = resp.cookies
            rescue RestClient::ResourceNotFound => e
              error = JSON.parse(e.response.body)
              raise StandardError.new(error["error"])
            rescue RestClient::ExceptionWithResponse => e
              error = JSON.parse(e.response.body)
              raise StandardError.new(error["error"])
            rescue RestClient::Exception => e
              "base REST exception " + e.message
            rescue Exception => e
              "exception occured " + e.message
            end
          end
          attr_reader :our_id, :session_cookies, :meta
          def self.method_missing(method_name, *args)
            begin
              JSON.parse(RestClient.get('#{server_url}/class/#{name}/msg/' + method_name.to_s + '/args/' + CGI.escape(JSON.generate(args))))[0]
            rescue RestClient::ResourceNotFound => e
              error = JSON.parse(e.response.body)
              raise StandardError.new(error["error"])
            rescue RestClient::ExceptionWithResponse => e
              error = JSON.parse(e.response.body)
              raise StandardError.new(error["error"])
            rescue RestClient::Exception => e
              "base REST exception " + e.message
            rescue Exception => e
              "exception occured " + e.message
            end
          end
      EOC
      if put_needs_method_arg?
        f.puts <<-EOC
          def method_missing(method_name, *args)
            begin
              JSON.parse(RestClient.post('#{server_url}/object/' + @our_id.to_s + '/msg/' + method_name.to_s, 
                {:args => JSON.generate(args), :_method => 'PUT'}, {:cookies => @session_cookies}))[0]
            rescue RestClient::ExceptionWithResponse => e
              error = JSON.parse(e.response.body)
              raise StandardError.new(error["error"])
            rescue RestClient::Exception => e
              "base REST exception " + e.message
            rescue Exception => e
              "exception occured " + e.message
            end
          end
        EOC
      else
        f.puts <<-EOC
          def method_missing(method_name, *args)
            begin
              JSON.parse(RestClient.put('#{server_url}/object/' + @our_id.to_s + '/msg/' + method_name.to_s, 
                {:args => JSON.generate(args)}, {:cookies => @session_cookies}))[0]
              rescue RestClient::ExceptionWithResponse => e
                error = JSON.parse(e.response.body)
                raise StandardError.new(error["error"])
              rescue RestClient::Exception => e
                "base REST exception " + e.message
            rescue Exception => e
              "exception occured " + e.message
            end
          end
        EOC
      end
      f.puts "\nend";
    end unless File.exists?(class_path)
    require class_path
    klass = const_get(name)
    return klass if klass
    raise "Class not found: #{name}"    
  end
end