require 'rubygems'
require 'json'
require 'rest_client'
require 'cgi'
require 'spec_wire'

class ClassProxy
  attr_reader :our_id, :session_cookies, :meta

  def self.server_url
    SpecWire::Initializer.config.server_url
  end
  def server_url
    SpecWire::Initializer.config.server_url
  end
  def put_needs_method_arg?
    SpecWire::Initializer.config.put_needs_method_arg
  end

  def handle_other_exeption(e, additional_message='')
    raise StandardError.new("SpecWire " + additional_message + ": " + e.message)
  end

  def handle_rest_exception(e)
    begin
      error = JSON.parse(e.http_body)
      unless error.nil? or error['exception'].nil?
        klass = Kernel.const_get(error["exception"])
        raise klass.new(error["error"])
      else
        handle_pther_exception e, "Unknown exception"
      end
    rescue JSON::ParserError => e
      raise StandardError('SpecWire JSON decoding: ' + e.message)
    end
  end


  def initialize(*args)
    begin
      resp = RestClient.post("#{server_url}/class/#{self.class.name}", :args => JSON.generate(args))
      # puts "resp " + resp
      @meta = JSON.parse(resp)
      @our_id = @meta['id']
      @session_cookies = resp.cookies
    rescue RestClient::Exception => e
      handle_rest_exception e
    rescue SpecWireException => e
      handle_other_exception e
    end
  end
  
  def self.method_missing(method_name, *args)
    begin
      JSON.parse(RestClient.get("#{server_url}/class/#{self.name}/msg/" + method_name.to_s + '/args/' + CGI.escape(JSON.generate(args))))[0]
    rescue RestClient::Exception => e
      handle_rest_exception e
    rescue SpecWireException => e
      handle_other_exception e
    end
  end
  
  def default_payload(args)
    {:args => JSON.generate(args)}
  end
  
  def payload(args)
    default_payload(args).merge(put_needs_method_arg? ? {:_method=>'PUT'}  : {})
  end
  
  def method_missing(method_name, *args)
    begin
      if put_needs_method_arg?
      JSON.parse(RestClient.post("#{server_url}/object/" + @our_id.to_s + '/msg/' + method_name.to_s, 
        payload(args), {:cookies => @session_cookies}))[0]
    else
      JSON.parse(RestClient.put("#{server_url}/object/" + @our_id.to_s + '/msg/' + method_name.to_s, 
        payload(args), {:cookies => @session_cookies}))[0]
    end
    rescue RestClient::Exception => e
      handle_rest_exception e
    rescue SpecWireException => e
      handle_other_exception e
    end
  end
  
end