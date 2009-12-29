        require 'rubygems'
        require 'json'
        require 'rest_client'
        require 'cgi'
        class Bar
          def initialize(*args)
            resp = RestClient.post('http://localhost:4567/class/Bar', :args => JSON.generate(args))
            @meta = JSON.parse(resp)
            @our_id = @meta['id']
            @session_cookies = resp.cookies
          end
          attr_reader :our_id, :session_cookies, :meta
          def self.method_missing(method_name, *args)
            JSON.parse(RestClient.get('http://localhost:4567/class/Bar/msg/' + method_name.to_s + '/args/' + CGI.escape(JSON.generate(args))))[0]
          end
          def method_missing(method_name, *args)
            JSON.parse(RestClient.put('http://localhost:4567/object/' + @our_id.to_s + '/msg/' + method_name.to_s, 
              {:args => JSON.generate(args)}, {:cookies => @session_cookies}))[0]
          end

end
