        require 'json'
        require 'rest_client'
        require 'cgi'
        class Bar
          def initialize(*args)
            resp = RestClient.post('http://localhost/~edh/limonade/server.php/class/Bar', :args => JSON.generate(args))
            @meta = JSON.parse(resp)
            @our_id = @meta['id']
            @session_cookies = resp.cookies
          end
          attr_reader :our_id, :session_cookies, :meta
          def self.method_missing(method_name, *args)
            JSON.parse(RestClient.get('http://localhost/~edh/limonade/server.php/class/Bar/msg/' + method_name + '/args/' + CGI.escape(JSON.generate(args))))[0]
          end
          def method_missing(name, *args)
            JSON.parse(RestClient.post('http://localhost/~edh/limonade/server.php/object/' + @our_id.to_s + '/msg/' + name, 
              {:args => JSON.generate(args), :_method => 'PUT'}, {:cookies => @session_cookies}))[0]
          end

end
