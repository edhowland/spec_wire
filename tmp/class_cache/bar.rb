        require 'json'
        require 'rest_client'
        require 'cgi'
        class Bar
          def initialize(*args)
            @meta = JSON.parse(RestClient.post('http://localhost:4567/class/Bar', :args => JSON.generate(args)))
            @our_id = @meta['id']
          end
          attr_reader :our_id
          attr_reader :meta
          def self.method_missing(method_name, *args)
            JSON.parse(RestClient.get('http://localhost:4567/class/Bar/msg/' + method_name + '/args/' + CGI.escape(JSON.generate(args))))[0]
          end
          def method_missing(name, *args)
            JSON.parse(RestClient.put('http://localhost:4567/object/' + @our_id.to_s + '/msg/' + name, :args => JSON.generate(args)))[0]
          end
        end
